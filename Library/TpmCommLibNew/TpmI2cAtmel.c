/** @TpmI2cAtmel.c
  Basic TIS (TPM Interface Specification) functions.

Copyright (c) 2005 - 2012, V Lab Technologies. All rights reserved.<BR>
This program and the accompanying materials
are licensed and made available under the terms and conditions of the BSD License
which accompanies this distribution.  The full text of the license may be found at
http://opensource.org/licenses/bsd-license.php

THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS,
WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.

**/


#include "CommonHeader.h"

EFI_STATUS
EFIAPI
TpmI2cAtmelRecv (
  OUT 	UINT8 	*Data,
  IN 	UINT32 	Length)
{
	/* Read bytes from I2C */
	return 0;
}

EFI_STATUS
EFIAPI
TpmI2cAtmelSend (
  OUT 	UINT8 	*Data,
  IN 	UINT32 	Length)
{
	/* Send bytes over I2C */
	return 0;
}

UINT8
TpmI2cAtmelAccess (
  IN 	UINT32	Request)
{
	/* No access register */
	return 0;
}

UINT8
TpmI2cAtmelStatus (
  IN 	UINT32	Request)
{
	/* No status register */
	return 0;
}

TIS_TPM_DEVICE TIS_TPM_I2C_ATMEL = {
	.Base = 0,
	.Irq = 1,
	.Recv = TpmI2cAtmelRecv,
	.Send = TpmI2cAtmelSend,
	.Status = TpmI2cAtmelStatus,
	.Access = TpmI2cAtmelAccess,
};
