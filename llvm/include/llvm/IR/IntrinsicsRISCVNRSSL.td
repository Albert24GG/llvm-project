

// Posit f32 fadd
def int_posit_f32_add : Intrinsic<
    [llvm_float_ty],           
    [llvm_float_ty, llvm_float_ty],
    [IntrNoMem, Commutative, IntrSpeculatable]
>;
