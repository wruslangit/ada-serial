/* USER SPACE PARALLEL PORT USING PPDEV
 * File: ada_ppdev.h
 *
 *  Created on: Dec 4, 2020
 *      Author: wruslan
=========================================================== 
*/

#ifndef _ADA_PPDEV_H_
#define _ADA_PPDEV_H_

// ========================================================
int ada_open_parport(const char *the_port, int fd_attrib);
int ada_ioctl_ppexcl_parport(int fd_ada);
int ada_ioctl_ppclaim_parport(int fd_ada);
int ada_ioctl_ppnegot_mode(int fd_ada, int modetoset);
int ada_ioctl_ppsetmode_parport(int fd_ada, int modetoset);
int ada_ioctl_ppfcontrol_frob1(void);
int ada_ioctl_ppfcontrol_frob2(void);

int ada_ioctl_pprdata_readdataregister(int fd_ada);
int ada_ioctl_pprstatus_readstatusregister(int fd_ada);
int ada_ioctl_pprcontrol_readcontrolregister(int fd_ada);

int ada_ioctl_ppwdata_writedataregister(int fd_ada, int datatowrite);
// No write for status register. Only read status register.
int ada_ioctl_ppwcontrol_writecontrolregister(int fd_ada, int controltowrite);

int ada_ioctl_ppyield_parport(int fd_ada);
int ada_ioctl_ppdatadir_dataport(int fd_ada, int datadirection);
int ada_ioctl_ppwctlonirq_controlport(int fd_ada, int the_interrupt);
int ada_ioctl_ppclrirq_controlport(int fd_ada, int the_interrupt);
int ada_ioctl_ppsetphase_parport(int fd_ada, int the_phase);
int ada_ioctl_ppgettime_usec_parport(int fd); 
// ppsettime_used is not allowed.
int ada_ioctl_ppgetmodes_parport(int fd_ada, int the_ppmodes);
int ada_ioctl_ppgetmode_current(int fd_ada, int curr_ppmode);
int ada_ioctl_ppgetphase_current(int fd_ada, int curr_ppphase);
int ada_ioctl_ppsetflags_parport(int fd_ada, int the_flags);
int ada_ioctl_ppgetflags_parport(int fd_ada, int the_flags);

int ada_ioctl_pprelease_parport(void);
int ada_close_parport(int fd);
// ========================================================

#endif /* _ADA_PPDEV_H_ */

