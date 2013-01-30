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

/* MdePkg/Protocol/SmbusHc */
#include <Protocol/SmbusHc.h>
#include "CommonHeader.h"

#define TPM_MAXBUF 1024

EFI_SMBUS_HC_PROTOCOL *Smbus;

EFI_STATUS
EFIAPI
TpmI2cAtmelRecv (
  OUT 	UINT8 	*Data,
  IN 	UINTN 	Length
  )
{
	EFI_STATUS Status;
	EFI_SMBUS_DEVICE_ADDRESS SlaveAddress;
	UINTN	TpmHeaderLength = 10;
	UINTN	TpmResponseLength;
	UINT8	*Buffer[TPM_MAXBUF];

	if (Length > TPM_MAXBUF || Length < 10) {
		return -1;
	}

	SlaveAddress.SmbusDeviceAddress = 0x29;

	/* Read header */
	Status = Smbus->Execute(Smbus, SlaveAddress, 0, EfiSmbusReadBlock, FALSE, &TpmHeaderLength, Buffer);
	if (EFI_ERROR(Status)) {
		goto finished;
	}

	TpmResponseLength = Buffer[4];
	TpmResponseLength = TpmResponseLength << 8;
	TpmResponseLength += Buffer[5];

	if (TpmResponseLength <= TpmHeaderLength) {
		memcpy(Data, Buffer, 10);
		goto finished;
	}

	if (TpmResponseLength > Length) {
		return -1;
	}

	Smbus->Execute(Smbus, SlaveAddress, 0, EfiSmbusReadBlock, FALSE, &TpmResponseLength, Buffer);

	if (EFI_ERROR(Status)) {
		goto finished;
	}

	memcpy(Data, Buffer, TpmResponseLength);

finished:
	return Status;
}

EFI_STATUS
EFIAPI
TpmI2cAtmelSend (
  OUT 	UINT8 	*Data,
  IN 	UINTN 	Length)
{
	EFI_STATUS Status;
	EFI_SMBUS_DEVICE_ADDRESS SlaveAddress;

	if (Length > TPM_MAXBUF) {
		return -1;
	}

	SlaveAddress.SmbusDeviceAddress = 0x29;

	/* Send bytes over I2C */
	Status = Smbus->Execute(Smbus, SlaveAddress, 0, EfiSmbusWriteBlock, FALSE, &Length, Data);
	if (EFI_ERROR(Status)) {
		memset(Data, 0, Length);
	}

	return Status;
}

EFI_STATUS
EFIAPI
TpmI2cAtmelAccess (
  IN 	UINTN	Request)
{
	/* No access register */
	return 0;
}

BOOLEAN
TpmI2cAtmelStatus (
  IN 	UINTN	Request)
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
