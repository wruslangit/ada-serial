// File   : Cada_crs232.h
// Date   : Thu 24 Dec 2020 12:04:15 PM +08
// Env	   : Linux HPEliteBook8470p-Ub2004-rt38 5.4.66-rt38
// #1 SMP PREEMPT_RT Sat Sep 26 16:51:59 +08 2020 x86_64 x86_64 x86_64 GNU/Linux
// Author: WRY wruslandr@gmail.com
// ========================================================
// GNAT Studio Community 2020 (20200427) hosted on x86_64-pc-linux-gnu
// GNAT 9.3.1 targetting x86_64-linux-gnu
// SPARK Community 2020 (20200818)
//
// ========================================================
// STANDARD C-HEADER FILES
#include <stdio.h>
#include <string.h>
#include <termios.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <limits.h>
#include <sys/file.h>
#include <errno.h>

// ========================================================
// LIST OF CONSTANTS FOR Cada_crs232.c CODE
// ========================================================

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

#define SERIALDEV_NBR  38   // Total number of serial_devices
int     serial_device[SERIALDEV_NBR]; // Integer array defining each device
int     error;

struct termios new_port_settings, old_port_settings[SERIALDEV_NBR];

const char *serial_devices[SERIALDEV_NBR] = {
       "/dev/ttyS0", "/dev/ttyS1", "/dev/ttyS2", "/dev/ttyS3", "/dev/ttyS4",
       "/dev/ttyS5", "/dev/ttyS6", "/dev/ttyS7", "/dev/ttyS8", "/dev/ttyS9",
       "/dev/ttyS10", "/dev/ttyS11", "/dev/ttyS12", "/dev/ttyS13",
       "/dev/ttyS14", "/dev/ttyS15",
       "/dev/ttyUSB0", "/dev/ttyUSB1", "/dev/ttyUSB2", "/dev/ttyUSB3",
       "/dev/ttyUSB4", "/dev/ttyUSB5",
       "/dev/ttyAMA0", "/dev/ttyAMA1",
       "/dev/ttyACM0", "/dev/ttyACM1",
       "/dev/rfcomm0", "/dev/rfcomm1",
       "/dev/ircomm0", "/dev/ircomm1",
       "/dev/cuau0", "/dev/cuau1", "/dev/cuau2", "/dev/cuau3",
       "/dev/cuaU0", "/dev/cuaU1", "/dev/cuaU2", "/dev/cuaU3"};

// ========================================================
// LIST OF C-PROCEDURES
// ========================================================
void crs232_chars_put(int serialdev_num, const char *the_chars);
void crs232_enable_DTR(int serialdev_num);
void crs232_disable_DTR(int serialdev_num);
void crs232_enable_RTS(int serialdev_num);
void crs232_disable_RTS(int serialdev_num);
void crs232_flush_RX(int serialdev_num);
void crs232_flush_TX(int serialdev_num);
void crs232_flush_RXTX(int serialdev_num);
void crs232_close_device(int serialdev_num);

// ========================================================
// LIST OF C-FUNCTIONS
// ========================================================
int crs232_open_device(int serialdev_num, int baudrate, const char *mode, int flowctrl);
int crs232_poll_device(int serialdev_num, unsigned char *buffer, int size);
int crs232_send_byte(int serialdev_num, unsigned char byte);
int crs232_send_buffer(int serialdev_num, unsigned char *buffer, int size);
int crs232_isDCD_enabled(int serialdev_num);
int crs232_isRING_enabled(int serialdev_num);
int crs232_isCTS_enabled(int serialdev_num);
int crs232_isDSR_enabled(int serialdev_num);
int crs232_Get_Device_Number(const char *dev_string);

// ========================================================
// ALHAMDULILLAH 3 TIMES WRY.
// ========================================================

