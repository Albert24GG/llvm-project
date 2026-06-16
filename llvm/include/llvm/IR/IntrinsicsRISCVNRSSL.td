/**
 *==========================================================================
 *  NRSSL F32 Intrinsic Definitions
 *==========================================================================
 */

class NRSSL_F32_Int_Binary<LLVMType ret_ty, list<LLVMType> arg_tys>: 
    Intrinsic<[ret_ty], arg_tys,
              [IntrNoMem, Commutative, IntrSpeculatable]>;

class NRSSL_F32_Int_Unary<LLVMType ret_ty, LLVMType arg_ty>: 
    Intrinsic<[ret_ty], [arg_ty], [IntrNoMem, IntrSpeculatable]>;

defvar nrssl_nrs_names = [
  "morris",
  "morrisHeb",
  "morrisBiasHeb",
  "posit1",
  "posit2",
  "morrisUnaryHeb"
];

defvar nrssl_binary_ops = [
  "add",
  "sub",
  "mul",
  "div",
  "min",
  "max",
  "sgnj",
  "sgnjn",
  "sgnjx",
];

defvar nrssl_fcmp_ops = [
  "eq",
  "lt",
  "le"
];

foreach nrs_name = nrssl_nrs_names in {
    foreach op = nrssl_binary_ops in {
        def int_riscv_nrssl_f32_ # nrs_name # _ # op : NRSSL_F32_Int_Binary<llvm_float_ty, [llvm_float_ty, llvm_float_ty]>;
    }

    foreach fcmp_op = nrssl_fcmp_ops in {
        def int_riscv_nrssl_f32_ # nrs_name # _ # fcmp_op : NRSSL_F32_Int_Binary<llvm_i64_ty, [llvm_float_ty, llvm_float_ty]>;
    }

    def int_riscv_nrssl_f32_ # nrs_name # _sqrt : NRSSL_F32_Int_Unary<llvm_float_ty, llvm_float_ty>;
    def int_riscv_nrssl_f32_ # nrs_name # _cvtToInt : NRSSL_F32_Int_Unary<llvm_i64_ty, llvm_float_ty>;
    def int_riscv_nrssl_f32_ # nrs_name # _cvtToUInt : NRSSL_F32_Int_Unary<llvm_i64_ty, llvm_float_ty>;
    def int_riscv_nrssl_f32_ # nrs_name # _cvtFromInt : NRSSL_F32_Int_Unary<llvm_float_ty, llvm_i64_ty>;
    def int_riscv_nrssl_f32_ # nrs_name # _cvtFromUInt : NRSSL_F32_Int_Unary<llvm_float_ty, llvm_i64_ty>;
}
