// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.


  .section __TEXT,__text,regular,pure_instructions
  .globl _CALL_WITH_EH_FRAME
  .p2align 2
_CALL_WITH_EH_FRAME:

  .cfi_startproc

  // Configure the C++ exception handler personality routine. Normally the
  // compiler would emit ___gxx_personality_v0 here. The purpose of this
  // function is to use a custom personality routine.
  .cfi_personality 155, __ZN4base3mac21CxxPersonalityRoutineEi14_Unwind_ActionyP17_Unwind_ExceptionP15_Unwind_Context
  .cfi_lsda 16, CallWithEHFrame_exception_table

Lfunction_start:
  stp x29, x30, [sp, #-16]!
  mov x29, sp
  .cfi_def_cfa w29, 16
  .cfi_offset w30, -8
  .cfi_offset w29, -16

  // Load the function pointer from the block descriptor.
  ldr x8, [x0, #16]

  // Execute the block in the context of a C++ try{}.
Ltry_start:
  blr x8
Ltry_end:
  ldp x29, x30, [sp], #16
  ret

  // Landing pad for the exception handler. This should never be called, since
  // the personality routine will stop the search for an exception handler,
  // which will cause the runtime to invoke the default terminate handler.
Lcatch:
  bl ___cxa_begin_catch  // The ABI requires a call to the catch handler.
  brk #0x1  // In the event this is called, make it fatal.

Lfunction_end:
  .cfi_endproc

  // The C++ exception table that is used to identify this frame as an
  // exception handler. See https://llvm.org/docs/ExceptionHandling.html,
  // https://itanium-cxx-abi.github.io/cxx-abi/exceptions.pdf and
  // https://www.airs.com/blog/archives/464.
  .section __TEXT,__gcc_except_tab
  .p2align 2
CallWithEHFrame_exception_table:
  .byte 255  // DW_EH_PE_omit
  .byte 155  // DW_EH_PE_indirect | DW_EH_PE_pcrel | DW_EH_PE_sdata4
  // The number of bytes in this table
  .uleb128 Ltypes_table_base - Ltypes_table_ref_base

Ltypes_table_ref_base:
  .byte 1  // DW_EH_PE_uleb128
  // Callsite table length.
  .uleb128 Lcall_site_table_end - Lcall_site_table_start

Lcall_site_table_start:
// First callsite.
CS1_begin = Ltry_start - Lfunction_start
  .uleb128 CS1_begin
CS1_end = Ltry_end - Ltry_start
  .uleb128 CS1_end

// First landing pad.
LP1 = Lcatch - Lfunction_start
  .uleb128 LP1
  .uleb128 1  // Action record.

// Second callsite.
CS2_begin = Ltry_end - Lfunction_start
  .uleb128 CS2_begin
CS2_end = Lfunction_end - Ltry_end
  .uleb128 CS2_end

  // Second landing pad (none).
  .uleb128 0
  .uleb128 0  // No action.

Lcall_site_table_end:
  // Action table.
  // Action record 1.
  .uleb128 1  // Type filter -1.
  .uleb128 0  // No further action to take.

  // Types table.
  .p2align 2
  .long 0  // Type filter -1: no type filter for this catch(){} clause.

Ltypes_table_base:
  .p2align 2

