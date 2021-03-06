## @file
#  Security Module Package for All Architectures.
#
# Copyright (c) 2009 - 2012, Intel Corporation. All rights reserved.<BR>
# This program and the accompanying materials
# are licensed and made available under the terms and conditions of the BSD License
# which accompanies this distribution. The full text of the license may be found at
# http://opensource.org/licenses/bsd-license.php
#
# THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS,
# WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
#
##

[Defines]
  PLATFORM_NAME                  = SecurityPkg
  PLATFORM_GUID                  = B2C4614D-AE76-47ba-B876-5988BFED064F
  PLATFORM_VERSION               = 0.92
  DSC_SPECIFICATION              = 0x00010005
  OUTPUT_DIRECTORY               = Build/SecurityPkg
  SUPPORTED_ARCHITECTURES        = IA32|IPF|X64|EBC|ARM
  BUILD_TARGETS                  = DEBUG|RELEASE
  SKUID_IDENTIFIER               = DEFAULT
  
  ## Set to TRUE to use a version of Library/TpmComm, Tcg/TcgDxe, Tcg/TcgPie
  DEFINE 	TPM_COMM_NEW		 = FALSE

[LibraryClasses]
  DebugLib|MdePkg/Library/BaseDebugLibNull/BaseDebugLibNull.inf
  DebugPrintErrorLevelLib|MdePkg/Library/BaseDebugPrintErrorLevelLib/BaseDebugPrintErrorLevelLib.inf  
  BaseLib|MdePkg/Library/BaseLib/BaseLib.inf
  SynchronizationLib|MdePkg/Library/BaseSynchronizationLib/BaseSynchronizationLib.inf
  TimerLib|MdePkg/Library/BaseTimerLibNullTemplate/BaseTimerLibNullTemplate.inf
  BaseMemoryLib|MdePkg/Library/BaseMemoryLib/BaseMemoryLib.inf
  MemoryAllocationLib|MdePkg/Library/UefiMemoryAllocationLib/UefiMemoryAllocationLib.inf
  PrintLib|MdePkg/Library/BasePrintLib/BasePrintLib.inf
  UefiApplicationEntryPoint|MdePkg/Library/UefiApplicationEntryPoint/UefiApplicationEntryPoint.inf

  DxeServicesLib|MdePkg/Library/DxeServicesLib/DxeServicesLib.inf
  UefiDriverEntryPoint|MdePkg/Library/UefiDriverEntryPoint/UefiDriverEntryPoint.inf
  UefiBootServicesTableLib|MdePkg/Library/UefiBootServicesTableLib/UefiBootServicesTableLib.inf
  DevicePathLib|MdePkg/Library/UefiDevicePathLib/UefiDevicePathLib.inf
  UefiLib|MdePkg/Library/UefiLib/UefiLib.inf
  DxeServicesTableLib|MdePkg/Library/DxeServicesTableLib/DxeServicesTableLib.inf
  UefiRuntimeServicesTableLib|MdePkg/Library/UefiRuntimeServicesTableLib/UefiRuntimeServicesTableLib.inf
  UefiRuntimeLib|MdePkg/Library/UefiRuntimeLib/UefiRuntimeLib.inf
  HiiLib|MdeModulePkg/Library/UefiHiiLib/UefiHiiLib.inf
  UefiHiiServicesLib|MdeModulePkg/Library/UefiHiiServicesLib/UefiHiiServicesLib.inf
  PcdLib|MdePkg/Library/BasePcdLibNull/BasePcdLibNull.inf
  IntrinsicLib|CryptoPkg/Library/IntrinsicLib/IntrinsicLib.inf
  OpensslLib|CryptoPkg/Library/OpensslLib/OpensslLib.inf
  IoLib|MdePkg/Library/BaseIoLibIntrinsic/BaseIoLibIntrinsic.inf
!if $(TPM_COMM_NEW) == TRUE
  TpmCommLib|SecurityPkg/Library/TpmCommLibNew/TpmCommLib.inf
!else
  TpmCommLib|SecurityPkg/Library/TpmCommLib/TpmCommLib.inf
!endif
  PlatformSecureLib|SecurityPkg/Library/PlatformSecureLibNull/PlatformSecureLibNull.inf
  TcgPhysicalPresenceLib|SecurityPkg/Library/DxeTcgPhysicalPresenceLib/DxeTcgPhysicalPresenceLib.inf
  TpmMeasurementLib|SecurityPkg/Library/DxeTpmMeasurementLib/DxeTpmMeasurementLib.inf

[LibraryClasses.common.PEIM]
  PeimEntryPoint|MdePkg/Library/PeimEntryPoint/PeimEntryPoint.inf
  PeiServicesLib|MdePkg/Library/PeiServicesLib/PeiServicesLib.inf
  PeiServicesTablePointerLib|MdePkg/Library/PeiServicesTablePointerLib/PeiServicesTablePointerLib.inf
  HobLib|MdePkg/Library/PeiHobLib/PeiHobLib.inf
  MemoryAllocationLib|MdePkg/Library/PeiMemoryAllocationLib/PeiMemoryAllocationLib.inf
  BaseCryptLib|CryptoPkg/Library/BaseCryptLib/PeiCryptLib.inf

[LibraryClasses.common.DXE_DRIVER]
  HobLib|MdePkg/Library/DxeHobLib/DxeHobLib.inf
  ReportStatusCodeLib|MdeModulePkg/Library/DxeReportStatusCodeLib/DxeReportStatusCodeLib.inf
  BaseCryptLib|CryptoPkg/Library/BaseCryptLib/BaseCryptLib.inf

[LibraryClasses.common.UEFI_DRIVER, LibraryClasses.common.DXE_RUNTIME_DRIVER, LibraryClasses.common.DXE_SAL_DRIVER,]
  HobLib|MdePkg/Library/DxeHobLib/DxeHobLib.inf
  DebugLib|MdePkg/Library/UefiDebugLibConOut/UefiDebugLibConOut.inf

[LibraryClasses.common.DXE_RUNTIME_DRIVER]
  BaseCryptLib|CryptoPkg/Library/BaseCryptLib/RuntimeCryptLib.inf

[LibraryClasses.common.UEFI_DRIVER, LibraryClasses.common.UEFI_APPLICATION]
  BaseCryptLib|CryptoPkg/Library/BaseCryptLib/BaseCryptLib.inf

[LibraryClasses.IPF.DXE_SAL_DRIVER]
  ExtendedSalLib|MdePkg/Library/DxeRuntimeExtendedSalLib/DxeRuntimeExtendedSalLib.inf
  BaseCryptLib|CryptoPkg/Library/BaseCryptLibRuntimeCryptProtocol/BaseCryptLibRuntimeCryptProtocol.inf

[LibraryClasses.common.DXE_SMM_DRIVER]
  HobLib|MdePkg/Library/DxeHobLib/DxeHobLib.inf
  SmmServicesTableLib|MdePkg/Library/SmmServicesTableLib/SmmServicesTableLib.inf
  MemoryAllocationLib|MdePkg/Library/SmmMemoryAllocationLib/SmmMemoryAllocationLib.inf
  BaseCryptLib|CryptoPkg/Library/BaseCryptLib/SmmCryptLib.inf
    
[LibraryClasses.ARM]
  NULL|ArmPkg/Library/CompilerIntrinsicsLib/CompilerIntrinsicsLib.inf    
    
[Components]
  #SecurityPkg/VariableAuthenticated/Pei/VariablePei.inf
  SecurityPkg/Library/DxeImageVerificationLib/DxeImageVerificationLib.inf
  SecurityPkg/Library/DxeDeferImageLoadLib/DxeDeferImageLoadLib.inf
  SecurityPkg/Library/DxeImageAuthenticationStatusLib/DxeImageAuthenticationStatusLib.inf
  SecurityPkg/UserIdentification/UserIdentifyManagerDxe/UserIdentifyManagerDxe.inf
  SecurityPkg/UserIdentification/UserProfileManagerDxe/UserProfileManagerDxe.inf
  SecurityPkg/UserIdentification/PwdCredentialProviderDxe/PwdCredentialProviderDxe.inf
  SecurityPkg/UserIdentification/UsbCredentialProviderDxe/UsbCredentialProviderDxe.inf

  #
  # Application
  #
  SecurityPkg/Application/VariableInfo/VariableInfo.inf

  #
  # TPM
  #
  SecurityPkg/Library/DxeTpmMeasureBootLib/DxeTpmMeasureBootLib.inf
!if $(TPM_COMM_NEW) == TRUE
  SecurityPkg/Tcg/TcgPeiNew/TcgPei.inf
  SecurityPkg/Tcg/TcgDxeNew/TcgDxe.inf
!else
  SecurityPkg/Tcg/TcgPei/TcgPei.inf
  SecurityPkg/Tcg/TcgDxe/TcgDxe.inf
!endif
  SecurityPkg/Tcg/PhysicalPresencePei/PhysicalPresencePei.inf
  SecurityPkg/Tcg/MemoryOverwriteControl/TcgMor.inf
  SecurityPkg/Tcg/TcgConfigDxe/TcgConfigDxe.inf {
    <LibraryClasses>
      PcdLib|MdePkg/Library/DxePcdLib/DxePcdLib.inf
  }
  SecurityPkg/Tcg/TcgSmm/TcgSmm.inf
  SecurityPkg/VariableAuthenticated/SecureBootConfigDxe/SecureBootConfigDxe.inf
  
[Components.IA32, Components.X64]
  SecurityPkg/VariableAuthenticated/RuntimeDxe/VariableRuntimeDxe.inf
  SecurityPkg/VariableAuthenticated/RuntimeDxe/VariableSmm.inf
  SecurityPkg/VariableAuthenticated/RuntimeDxe/VariableSmmRuntimeDxe.inf

[Components.IPF]
  SecurityPkg/VariableAuthenticated/EsalVariableDxeSal/EsalVariableDxeSal.inf 

[Components.EBC, Components.ARM]
# Build only
  SecurityPkg/VariableAuthenticated/RuntimeDxe/VariableRuntimeDxe.inf 

[BuildOptions]
  MSFT:*_*_IA32_DLINK_FLAGS = /ALIGN:256
  INTEL:*_*_IA32_DLINK_FLAGS = /ALIGN:256
  

