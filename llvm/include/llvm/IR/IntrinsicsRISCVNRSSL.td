
/**
 *==========================================================================
 *  NRSSL F32 Instruction Definitions
 *==========================================================================
 */

class NRSSL_F32_Instr: 
    Intrinsic<[llvm_float_ty], [llvm_float_ty, llvm_float_ty],
              [IntrNoMem, Commutative, IntrSpeculatable]>;


defvar nrssl_nrs_names = [
  "morris",
  "morrisHeb",
  "morrisBiasHeb",
  "posit1",
  "posit2",
  "morrisUnaryHeb"
];

defvar nrssl_ops = [
  "add",
  "sub",
  "mul",
  "div",
  "sqrt",
  "eq",
  "lt",
  "le",
  "min",
  "max",
  "sgnj",
  "sgnjn",
  "sgnjx",
  "cvtToInt",
  "cvtFromInt",
];

foreach nrs_name = nrssl_nrs_names in {
    foreach op = nrssl_ops in {
        def int_riscv_nrssl_f32_ # nrs_name # _ # op : NRSSL_F32_Instr;
    }
}
