// File   : Cada_rs232.c
// Date   : Thu 24 Dec 2020 12:04:15 PM +08
// Env	   : Linux HPEliteBook8470p-Ub2004-rt38 5.4.66-rt38
// #1 SMP PREEMPT_RT Sat Sep 26 16:51:59 +08 2020 x86_64 x86_64 x86_64 GNU/Linux
// Author: WRY wruslandr@gmail.com
// ========================================================
// GNAT Studio Community 2020 (20200427) hosted on x86_64-pc-linux-gnu
// GNAT 9.3.1 targetting x86_64-linux-gnu
// SPARK Community 2020 (20200818)
/*
   UART is a communications protocol. UART has everything to do with logic
   and programming. UART is responsible for sending and receiving a sequence
   of bits. At the output of a UART these bits are usually represented by
   logic level voltages. These bits can become RS-232, RS-422, RS-485, or
   some other proprietary specification.

   RS232 defines the physical signal levels. It refers to the electronics and
   hardware needed for serial communications.

   LOOPBACK TEST. By looping the transmit and receive pins, you can test
   serial cable port communication by checking if the serial ports connections
   transmit and receive valid information.

     TRANSMITTER: When a node wants to transmit data to another node,
                  it sends out a RTS (Request to Send) packet.
     RECEIVER   : After the receiver receives the RTS packet,
                  it replies with a CTS (Cleared to Send) packet.
     TRANSMITTER: After the transmitter receives the CTS packet,
                  it transmits the data packets.

     Encoded within the RTS/CTS packets is a duration field.

*/
// ========================================================
#include "Cada_rs232.h"   // Bring in constants and function prototypes

// ADDED BY WRY
#include <time.h> 		  // For high-res timer clock_gettime with (nanoseconds)
#include <sys/time.h>	// For local date-time with (microseconds)
#include <unistd.h>    // getcwd(), close()
#include <limits.h>    // perror()
#include <stdio.h>     // For printf()
#include <string.h>    // For string slicing

// ========================================================
// GLOBAL VARIABLE DEFINITIONS
// ========================================================
time_t   	the_time;
char     the_strbuffer1[26];       // display date
char     the_strbuffer2[60];       // display date and local time
struct tm*      the_tminfo;
struct timeval  current_time;
struct timeval  thetime_sec_now;
struct timeval  thetime_usec_now;
struct timespec thetime_nsec_now;

// ========================================================
void convert_int2bin8(int input_int, char *output_bin8) {
// ========================================================
    unsigned int mask8;
    mask8  = 0b10000000;

    int bitposition = 0;
    while (mask8)  {        		  // Loop until MASK is empty
        bitposition++;
        if (input_int & mask8) {	// Bitwise AND => test the masked bit
            *output_bin8 = '1';   // if true, binary value 1 is appended to output array
        } else {
            *output_bin8 = '0';   // if false, binary value 0 is appended to output array
        } // END if..else
	      output_bin8++;            // next character
        mask8 >>= 1;              // shift the mask variable 1 bit to the right
    } // END while

    *output_bin8 = 0;             // add the trailing null
}
// ===================================================
void current_working_directory(void) {
// ===================================================
   char cwd[255];
   if (getcwd(cwd, sizeof(cwd)) != NULL) {
	   printf("Current directory: %s\n", cwd);
   } else {
	   perror("getcwd() error");
   }
}
// ========================================================
void display_date_only(void) {
// ========================================================
  time(&the_time);
  the_tminfo = localtime(&the_time);
  strftime(the_strbuffer1, 26, "%Y-%m-%d %H:%M:%S", the_tminfo);
  strftime(the_strbuffer2, 60, "%a %b %d, %Y %H:%M:%S", the_tminfo);
  printf("%s MYT(UTC+08) \n", the_strbuffer2);
}

// ========================================================
void slice_string(const char *str, char *buffer, size_t start, size_t end) {
// ========================================================
    size_t j = 0;
    for ( size_t i = start; i <= end; ++i ) {
        buffer[j++] = str[i];
    }
    buffer[j] = 0;
}

// ========================================================
int crs232_Get_Device_Number(const char *the_devstring) {
// ========================================================
  int idx, serdev_num;

  // CONVERT "const char *the_devstring" INTO "char dev_string[length]"
  int the_devstring_length = strlen(the_devstring);

  int i;
  char dev_string[the_devstring_length + 1];     // Plus trailing null '\0'
  for (i = 0; i <= the_devstring_length+1; i++) {
      dev_string[i] = the_devstring[i];
  }

  // COMPARE STRINGS USING strcomp() WITH LIST OF SERIAL DEVICES
  for (idx = 0; idx < SERIALDEV_NBR; idx++) {
      if (strcmp(dev_string, serial_devices[idx]) == 0 ) {
          serdev_num = idx;
      }
  } // END for

  if (serdev_num < 0 || serdev_num > SERIALDEV_NBR) {
      serdev_num = 999;
  } else {
      return(serdev_num);
  }

return(serdev_num);
}

// ========================================================
void crs232_chars_put(int serialdev_num, const char *the_chars) {
// ========================================================

  printf("EXECUTE: Write stream (the_chars) = %s \n", the_chars);

}

// ========================================================
int crs232_open_device(int serialdev_num, int baudrate,  const char *the_mode, int flowctrl) {
// ========================================================
  int  baudr;    // to set value of baudrate
  int  status;   // RS232 Flow Control signals

  // INITIALIZATION
  int  cbits = CS8;     // Value for bits per character = 8 (initialization)
  int  cpar  = 0;       // Initialize parity value
  int  ipar  = IGNPAR;  // Ignore parity
  int  bstop = 0;       // Stop bit value (1 or 2)

  printf("EXECUTE: Open serial device sequence \n");

  // CHECK SERIAL DEVICE FOR VALID INPUT PORT
  // Serial Device Number is listed in the header file, Cada_rs232.h
  if((serialdev_num >= SERIALDEV_NBR)||(serialdev_num < 0))   {
      printf("ERROR: open_device_01: Invalid Serial Device Number, serialdev_num = %d \n", serialdev_num);
  return(1);
  }
  printf("open_device_01: Valid Serial Device Number. serialdev_num = %d \n", serialdev_num);

  // SET SERIAL DEVICE BAUD RATE
  switch(baudrate) {
    case      50 : baudr = B50;
                   break;
    case      75 : baudr = B75;
                   break;
    case     110 : baudr = B110;
                   break;
    case     134 : baudr = B134;
                   break;
    case     150 : baudr = B150;
                   break;
    case     200 : baudr = B200;
                   break;
    case     300 : baudr = B300;
                   break;
    case     600 : baudr = B600;
                   break;
    case    1200 : baudr = B1200;
                   break;
    case    1800 : baudr = B1800;
                   break;
    case    2400 : baudr = B2400;
                   break;
    case    4800 : baudr = B4800;
                   break;
    case    9600 : baudr = B9600;
                   break;
    case   19200 : baudr = B19200;
                   break;
    case   38400 : baudr = B38400;
                   break;
    case   57600 : baudr = B57600;
                   break;
    case  115200 : baudr = B115200;
                   break;
    case  230400 : baudr = B230400;
                   break;
    case  460800 : baudr = B460800;
                   break;
    case  500000 : baudr = B500000;   // For linux, baudrate continue below
                   break;
    case  576000 : baudr = B576000;
                   break;
    case  921600 : baudr = B921600;
                   break;
    case 1000000 : baudr = B1000000;
                   break;
    case 1152000 : baudr = B1152000;
                   break;
    case 1500000 : baudr = B1500000;
                   break;
    case 2000000 : baudr = B2000000;
                   break;
    case 2500000 : baudr = B2500000;
                   break;
    case 3000000 : baudr = B3000000;
                   break;
    case 3500000 : baudr = B3500000;
                   break;
    case 4000000 : baudr = B4000000;
                   break;
    default      : printf("ERROR: open_device_02: Invalid setting for baudrate. = %d \n", baudrate);
                   return(1);
                   break;
  }
  printf("open_device_02: Valid setting for baudrate = %d \n", baudrate);

  // CONVERT const char *the_mode INTO char mode[length]
  int the_mode_length = strlen(the_mode);
  char mode[strlen(the_mode) + 1];
  int i;
  for (i = 0; i <= the_mode_length; i++) {
     mode[i] = the_mode[i];
  }

  // CHECK STRING LENGTH FOR DEVICE MODE
  // EXAMPLE: mode = "8N1" WHERE
  // mode[0] = Value of bits per character {5, 6, 7, 8})
  // mode[1] = Value for parity {n, e, o}
  // mode[2] = Value of number for stop bits  {1, 2}
  if((the_mode_length) != 3) {
      printf("ERROR: open_device_03: Invalid string length for mode setting \"%s\"\n", the_mode);
      return(1);
  }
  else {
      printf("open_device_03: Valid string length for mode setting \"%s\" = %d\n", the_mode, the_mode_length);
  }

  // SET VALUE FOR BITS PER CHARACTER
  switch(mode[0])  {
    case '8': cbits = CS8;
              break;
    case '7': cbits = CS7;
              break;
    case '6': cbits = CS6;
              break;
    case '5': cbits = CS5;
              break;
    default : printf("ERROR: open_device_04: Invalid number for bits per character = '%c'\n", mode[0]);
              return(1);
              break;
  }
  printf("open_device_04: Valid number for bits per character = '%c'\n", mode[0]);

  // SET VALUE FOR CHARACTER PARITY (COUNTING BIT 1)
  // Parity even (the total number of 1s is even)
  // Parity odd  (the total number of 1s is odd )
  switch(mode[1]) {
    case 'N':                 // NO PARITY
    case 'n': cpar = 0;
              ipar = IGNPAR;
              break;
    case 'E':                 // EVEN PARITY
    case 'e': cpar = PARENB;
              ipar = INPCK;
              break;
    case 'O':                 // EVEN AND ODD PARITY
    case 'o': cpar = (PARENB | PARODD);
              ipar = INPCK;
              break;
    default : printf("ERROR: open_device_05: Invalid setting for parity = '%c'\n", mode[1]);
              return(1);
              break;
  }
  printf("open_device_05: Valid setting for parity, = '%c'\n", mode[1]);

  // SET VALUE FOR NUMBER OF STOP BITS
  switch(mode[2]) {
    case '1': bstop = 0;
              break;
    case '2': bstop = CSTOPB;
              break;
    default : printf("ERROR: open_device_06: Invalid setting for number of stop bits, = '%c'\n", mode[2]);
              return(1);
              break;
  }
  printf("open_device_06: Valid setting for number of stop bits = '%c'\n", mode[2]);

/*
http://pubs.opengroup.org/onlinepubs/7908799/xsh/termios.h.html

http://man7.org/linux/man-pages/man3/termios.3.html
*/

  serial_device[serialdev_num] = open(serial_devices[serialdev_num], O_RDWR | O_NOCTTY | O_NDELAY);
  if(serial_device[serialdev_num] == -1) {
    perror("ERROR: open_device_07: Unable to set serial device attributes \n");
    return(1);
  }
  else {
  printf("open_device_07: Able to set serial device attributes\n");
  }

  /* lock access so that another process can't also use the port */
  if(flock(serial_device[serialdev_num], LOCK_EX | LOCK_NB) != 0) {
    close(serial_device[serialdev_num]);
    perror("ERROR: open_device_08: Another process have locked the serial device \n");
    return(1);
  }
  else {
    printf("open_device_08: No process have locked the serial device \n");
  }

  error = tcgetattr(serial_device[serialdev_num], old_port_settings + serialdev_num);
  if(error == -1) {
    close(serial_device[serialdev_num]);
    flock(serial_device[serialdev_num], LOCK_UN);  // free the port so that others can use it.
    perror("ERROR: open_device_09: Unable to read previous serial device settings \n");
    // return(1);
  }
  else {
     printf("open_device_09: Able to read previous serial device settings \n");
  }

  memset(&new_port_settings, 0, sizeof(new_port_settings));  // clear the new struct

  new_port_settings.c_cflag = cbits | cpar | bstop | CLOCAL | CREAD;
  if(flowctrl == 1) {
      //new_port_settings.c_cflag |= CRTSCTS;
      new_port_settings.c_cflag = cbits | cpar | bstop | CLOCAL | CREAD;
  }
  printf("open_device_10: Setting for flowctrl = %d \n", flowctrl);

  new_port_settings.c_iflag = ipar;
  new_port_settings.c_oflag = 0;
  new_port_settings.c_lflag = 0;
  new_port_settings.c_cc[VMIN] = 0;      // block untill n bytes are received
  new_port_settings.c_cc[VTIME] = 0;     // block untill a timer expires (n * 100 mSec.)

  cfsetispeed(&new_port_settings, baudr);  // input baudrate
  cfsetospeed(&new_port_settings, baudr);  // output baudrate

  error = tcsetattr(serial_device[serialdev_num], TCSANOW, &new_port_settings);
  if(error == -1) {
    tcsetattr(serial_device[serialdev_num], TCSANOW, old_port_settings + serialdev_num);
    close(serial_device[serialdev_num]);
    flock(serial_device[serialdev_num], LOCK_UN);  // free the port so that others can use it.
    perror("ERROR: open_device_11: Unable to apply new serial device settings \n");
    // return(1);
  }
  else {
    printf("open_device_11: Able to apply new serial device settings \n");
  }

  /* http://man7.org/linux/man-pages/man4/tty_ioctl.4.html */

  status = ioctl(serial_device[serialdev_num], TIOCMGET, &status);

  if(ioctl(serial_device[serialdev_num], TIOCMGET, &status) == -1)   {
    tcsetattr(serial_device[serialdev_num], TCSANOW, old_port_settings + serialdev_num);
    flock(serial_device[serialdev_num], LOCK_UN);  /* free the port so that others can use it. */
    perror("ERROR: open_device_12: Unable to get serial device status \n");
    // return(1);
  }
  else {
    printf("open_device_12: Able to get serial device status. status = %d \n", status);
  }

  status |= TIOCM_DTR;    // turn on DTR (Data Terminal Ready)
  // printf("EXECUTE: DTR ON (Data Terminal Ready turned ON) \n");
  status |= TIOCM_RTS;    // turn on RTS (Request to Send)
  // printf("EXECUTE: RTS ON (Request To Send turned ON) \n");

  if(ioctl(serial_device[serialdev_num], TIOCMSET, &status) == -1) {
    tcsetattr(serial_device[serialdev_num], TCSANOW, old_port_settings + serialdev_num);
    flock(serial_device[serialdev_num], LOCK_UN);  /* free the port so that others can use it. */
    printf("ERROR: open_device_13: Unable to set serial device status. status = %d \n", status);
    // return(1);
  }
  else {
    printf("open_device_13: Able to set serial device status. status = %d \n", status);
  }

  return(0);
}

// ========================================================
int crs232_read_buffer(int serialdev_num, unsigned char *buffer, int size) {
// ========================================================
  int n = read(serial_device[serialdev_num], buffer, size);

  if (n < 0) {     // NEGATIVE n = Number of bytes read

      if(errno == EAGAIN) {
          printf("ERROR: read_buffer_01: errno == EAGAIN = %d, Bytes read = %d \n", errno, n);
          printf("READ AGAIN: Partial buffer read = %s, Buffer size = %d \n", buffer, size);
      }

  } if ( n == 0) { // ZERO n = Number of bytes read
      printf("SUCCESS: read_buffer_01: No data in buffer. Bytes read = %d \n", n);

  } else {        // POSITIVE n = Number of bytes read
      printf("SUCCESS: read_buffer_01: Data in buffer = %s, Bytes read = %d, Buffer size = %d \n", buffer, n, size);
  }

return(n);  // number of bytes read
}

// ==========================================================
int crs232_send_byte(int serialdev_num, unsigned char byte) {
// ==========================================================

  int n = write(serial_device[serialdev_num], &byte, 1);

  if (n < 0) {
      if(errno == EAGAIN) {
           printf("ERROR: send_byte_01: errno == EAGAIN = %d, Byte sent = %c, No. of bytes = %d \n", errno, byte, n);
       }
  } else if (n == 0) {
      printf("SUCCESS: send_byte_01: Byte sent = %c, No. of bytes = %d \n", byte, n);
  } else if (n == 1) {
      printf("SUCCESS: send_byte_01: Byte sent = %c, No. of bytes = %d \n", byte, n);
  } else {  // For (n > 1)
      printf("ERROR: send_byte_01: Unknown error. Byte sent = %c, No. of bytes = %d \n", byte, n);
  }

return(0);
}

// ========================================================
int crs232_send_buffer(int serialdev_num, unsigned char *buffer, int size) {
// ========================================================

  int n = write(serial_device[serialdev_num], buffer, size);

  if (n < 0) {
      if(errno == EAGAIN) {
           printf("ERROR: send_buffer_01: errno == EAGAIN = %d, Buffer size = %d, Buffer sent = %s, No. of bytes sent = %d \n", errno, size, buffer, n);
       }
  } else if (n == 0) {
      printf("SUCCESS: send_buffer_01: Buffer size = %d, Buffer sent = %s, No. of bytes sent = %d \n", size, buffer, n);

  } else {
      printf("SUCCESS: send_buffer_01: Buffer size = %d, Buffer sent = %s, No. of bytes sent = %d \n", size, buffer, n);
  }

  return(n);  // nunber of bytes sent
}

// ========================================================
void crs232_close_device(int serialdev_num) {
// ========================================================
  int status = ioctl(serial_device[serialdev_num], TIOCMGET, &status);

  printf("EXECUTE: Close serial device sequence \n");

  if(ioctl(serial_device[serialdev_num], TIOCMGET, &status) == -1)  {
    perror("ERROR: close_device_01: Unable to get serial device. ");
    printf("status = %d \n", status);
  } else {

    printf("close_device_01: Get serial device[%d]. status = %d \n", serialdev_num, status);
  }

  status &= ~TIOCM_DTR;    // turn off DTR
  // printf("EXECUTE: disable_DTR (Data Terminal Ready turned OFF) \n");

  status &= ~TIOCM_RTS;    // turn off RTS
  // printf("EXECUTE: disable_RTS (Request To Send turned OFF) \n");

  if(ioctl(serial_device[serialdev_num], TIOCMSET, &status) == -1) {
    perror("ERROR: close_device_02: Unable to set serial device status. ");
    printf("status = %d \n", status);
  } else {
    printf("close_device_02: Set serial device[%d]. status = %d \n", serialdev_num, status);
  }

  tcsetattr(serial_device[serialdev_num], TCSANOW, old_port_settings + serialdev_num);

  close(serial_device[serialdev_num]);
  printf("close_device_03: Close serial_device[%d]. status = %d \n", serialdev_num, status);

  flock(serial_device[serialdev_num], LOCK_UN);  // free the port so others can use it. */
  printf("close_device_04: Finally unlock (free) serial_device[%d]. status = %d \n", serialdev_num, status);

}

/*
Constant  Description
TIOCM_LE        DSR (data set ready/line enable)
TIOCM_DTR       DTR (data terminal ready)
TIOCM_RTS       RTS (request to send)
TIOCM_ST        Secondary TXD (transmit)
TIOCM_SR        Secondary RXD (receive)
TIOCM_CTS       CTS (clear to send)
TIOCM_CAR       DCD (data carrier detect)
TIOCM_CD        see TIOCM_CAR
TIOCM_RNG       RNG (ring)
TIOCM_RI        see TIOCM_RNG
TIOCM_DSR       DSR (data set ready)

http://man7.org/linux/man-pages/man4/tty_ioctl.4.html
*/

// ========================================================
int crs232_isDCD_enabled(int serialdev_num) {
// ========================================================
  int status = ioctl(serial_device[serialdev_num], TIOCMGET, &status);

  if(status&TIOCM_CAR) {
    perror("CHECKED: NO isDCD_enabled: (Data Carrier Detect) is not enabled. ");
    printf("status = %d \n", status);
    return(1);
  } else {
    printf("CHECKED: YES isDCD_enabled: (Data Carrier Detect) is enabled. status = %d \n", status);
    return(0);
  }
}

// ========================================================
int crs232_isRING_enabled(int serialdev_num) {
// ========================================================
  int status = ioctl(serial_device[serialdev_num], TIOCMGET, &status);

  if(status&TIOCM_RNG) {
    // printf("value = %d \n", status&TIOCM_RNG);
    perror("CHECKED: NO isRING_enabled_01: (Ring) is not enabled. ");
    printf("status = %d \n", status);
    return(1);
  } else {
    // printf("value = %d \n", status&TIOCM_RNG);
    printf("CHECKED: YES isRING_enabled_01: (Ring) is enabled. status = %d \n", status);
    return(0);
  }
}

// ========================================================
int crs232_isCTS_enabled(int serialdev_num) {
// ========================================================
  int status =  ioctl(serial_device[serialdev_num], TIOCMGET, &status);

  if(status&TIOCM_CTS) {
    perror("CHECKED: NO isCTS_enabled_01: (Clear To Send) is not enabled. ");
    printf("status = %d \n", status);
    return(1);
  } else {
    printf("CHECKED: YES isCTS_enabled_01: (Clear To Send) is enabled. status = %d \n", status);
    return(0);
  }
}

// ========================================================
int crs232_isDSR_enabled(int serialdev_num) {
// ========================================================
  int status = ioctl(serial_device[serialdev_num], TIOCMGET, &status);

  if(status&TIOCM_DSR) {
    perror("CHECKED: NO isDSR_enabled_01: (Data Set Ready) is not enabled. ");
    printf("status = %d \n", status);
    return(1);
  } else {
    printf("CHECKED: YES isDSR_enabled_01: (Data Set Ready) is enabled. status = %d \n", status);
    return(0);
  }

}

// ========================================================
void crs232_enable_DTR(int serialdev_num) {
// ========================================================
  int status;

  if(ioctl(serial_device[serialdev_num], TIOCMGET, &status) == -1) {
      perror("ERROR: enable_DTR_01: (Data Terminal Ready) Unable to get serial_device. ");
      printf("status = %d \n", status);
  }
  // else {
  //    printf("SUCCESS: enable_DTR_01: (Data Terminal Ready) Able to get serial_device. status = %d \n", status);
  // }

  status |= TIOCM_DTR;    // turn on DTR
  printf("EXECUTE: DTR ON (enable_DTR) (Data Terminal Ready turned ON) \n");

  if(ioctl(serial_device[serialdev_num], TIOCMSET, &status) == -1)   {
    perror("ERROR: enable_DTR_02: (Data Terminal Ready) Unable to set serial_device. ");
    printf("status = %d \n", status);
  }
  // else {
  //  printf("SUCCESS: enable_DTR_02: (Data Terminal Ready) Able to set serial_device. status = %d \n", status);
  //}

}

// ========================================================
void crs232_disable_DTR(int serialdev_num) {
// ========================================================
  int status;

  if(ioctl(serial_device[serialdev_num], TIOCMGET, &status) == -1) {
     perror("ERROR: disable_DTR_01: (Data Terminal Ready) Unable to get serial_device. ");
     printf("status = %d \n", status);
  }
  // else {
  //   printf("SUCCESS: disable_DTR_01: (Data Terminal Ready) Able to get serial_device. status = %d \n", status);
  // }

  status &= ~TIOCM_DTR;    // turn off DTR
  printf("EXECUTE: DTR OFF (disable_DTR) (Data Terminal Ready turned OFF) \n");

  if(ioctl(serial_device[serialdev_num], TIOCMSET, &status) == -1)  {
      perror("ERROR: disable_DTR_02: (Data Terminal Ready) Unable to set serial device. ");
      printf("status = %d \n", status);
  }
  // else {
  //   printf("SUCCESS: disable_DTR_02: (Data Terminal Ready) Able to set serial_device. status = %d \n", status);
  // }

}
// ========================================================
void crs232_enable_RTS(int serialdev_num) {
// ========================================================
  int status;

  if(ioctl(serial_device[serialdev_num], TIOCMGET, &status) == -1) {
    perror("ERROR: enable_RTS_01: (Request To Send) Unable to get serial device. ");
    printf("status = %d \n", status);
  }
  // else {
  //   printf("SUCCESS: enable_RTS_01: (Request To Send) Able to get serial_device. status = %d \n", status);
  // }

  status |= TIOCM_RTS;    // turn on RTS
  printf("EXECUTE: RTS ON (enable_RTS) (Request To Send turned ON) \n");

  if(ioctl(serial_device[serialdev_num], TIOCMSET, &status) == -1) {
     perror("ERROR: enable_RTS_02: (Request To Send) Unable to set serial device. ");
     printf("status = %d \n", status);
  }
  // else {
  //   printf("SUCCESS: enable_RTS_02: (Request To Send) Able to set serial_device. status = %d \n", status);
  // }

}
// ========================================================
void crs232_disable_RTS(int serialdev_num) {
// ========================================================
  int status;

  if(ioctl(serial_device[serialdev_num], TIOCMGET, &status) == -1) {
     perror("ERROR: disable_RTS_01: (Request To Send) Unable to get derial device. ");
     printf("status = %d \n", status);
  }
  // else {
  //   printf("SUCCESS: disable_RTS_01: (Request To Send) Able to get serial_device. status = %d \n", status);
  // }

  status &= ~TIOCM_RTS;    // turn off RTS
  printf("EXECUTE: RTS OFF (disable_RTS) (Request To Send turned OFF) \n");

  if(ioctl(serial_device[serialdev_num], TIOCMSET, &status) == -1) {
     perror("ERROR: disable_RTS_02: (Request To Send) Unable to set serial device. ");
     printf("status = %d \n", status);
  }
  // else {
  //   printf("SUCCESS: disable_RTS_02: (Request To Send) Able to set serial_device. status = %d \n", status);
  // }

}
// ========================================================
void crs232_flush_RX(int serialdev_num) {
// ========================================================
    tcflush(serial_device[serialdev_num], TCIFLUSH);
    printf("EXECUTE: flush_RX Receive(Input) Buffer \n");
}

// ========================================================
void crs232_flush_TX(int serialdev_num) {
// ========================================================
    tcflush(serial_device[serialdev_num], TCOFLUSH);
    printf("EXECUTE: flush_TX Transmit(Output) Buffer \n");
}

// ========================================================
void crs232_flush_RXTX(int serialdev_num) {
// ========================================================
    tcflush(serial_device[serialdev_num], TCIOFLUSH);
    printf("EXECUTE: flush_RXTX both Receive and Transmit Buffers \n");
}

// ========================================================
// ALHAMDULILLAH 3 TIMES WRY.
// ========================================================

