/**
 *==========================================================================
 *  NRSSL F32 Instruction Definitions
 *==========================================================================
 */

def NRSSL_OPC : RISCVOpcode<"NRSSL", 0b0001011>;

class NRSSLInstrBinary<bits<7> op, bits<3> nrs_id, RegisterClass rc_out, list<RegisterClass> rc_ins, string int_str, string opstr> :
    RVInstR< 
        op,
        nrs_id,
        NRSSL_OPC,
        (outs rc_out:$rd),
        (ins rc_ins[0]:$rs1, rc_ins[1]:$rs2),
        opstr,
        "$rd, $rs1, $rs2"> {

  let Pattern = [
    (
      set rc_out:$rd,
      (!cast<Intrinsic>(int_str) rc_ins[0]:$rs1, rc_ins[1]:$rs2)
    )
  ];

  let mayStore = 0;
  let mayLoad = 0;
  let hasSideEffects = 0;
}

class NRSSLInstrUnary<bits<7> op, bits<3> nrs_id, RegisterClass rc_out, RegisterClass rc_in, string int_str, string opstr, bits<5> rs2_ = 0> :
    RVInstR< 
        op,
        nrs_id,
        NRSSL_OPC,
        (outs rc_out:$rd),
        (ins rc_in:$rs1),
        opstr,
        "$rd, $rs1"> {

  let rs2 = rs2_;

  let Pattern = [
    (
      set rc_out:$rd,
      (!cast<Intrinsic>(int_str) rc_in:$rs1)
    )
  ];


  let mayStore = 0;
  let mayLoad = 0;
  let hasSideEffects = 0;
}

multiclass NRSSLOpGroup<bits<3> nrs_id, string int_prefix_str> {
  def _ADD : NRSSLInstrBinary<0b0000000, nrs_id, FPR32, [FPR32, FPR32], int_prefix_str # "_add", "fadd">;
  def _SUB : NRSSLInstrBinary<0b0000001, nrs_id, FPR32, [FPR32, FPR32], int_prefix_str # "_sub", "fsub">;
  def _MUL : NRSSLInstrBinary<0b0000010, nrs_id, FPR32, [FPR32, FPR32], int_prefix_str # "_mul", "fmul">;
  def _DIV : NRSSLInstrBinary<0b0000011, nrs_id, FPR32, [FPR32, FPR32], int_prefix_str # "_div", "fdiv">;
  def _EQ : NRSSLInstrBinary<0b0000101, nrs_id, GPR, [FPR32, FPR32], int_prefix_str # "_eq", "feq">;
  def _LT : NRSSLInstrBinary<0b0000110, nrs_id, GPR, [FPR32, FPR32], int_prefix_str # "_lt", "flt">;
  def _LE : NRSSLInstrBinary<0b0000111, nrs_id, GPR, [FPR32, FPR32], int_prefix_str # "_le", "fle">;
  def _MIN : NRSSLInstrBinary<0b0001000, nrs_id, FPR32, [FPR32, FPR32], int_prefix_str # "_min", "fmin">;
  def _MAX : NRSSLInstrBinary<0b0001001, nrs_id, FPR32, [FPR32, FPR32], int_prefix_str # "_max", "fmax">;
  def _SGNJ : NRSSLInstrBinary<0b0001010, nrs_id, FPR32, [FPR32, FPR32], int_prefix_str # "_sgnj", "sgnj">;
  def _SGNJN : NRSSLInstrBinary<0b0001011, nrs_id, FPR32, [FPR32, FPR32], int_prefix_str # "_sgnjn", "sgnjn">;
  def _SGNJX : NRSSLInstrBinary<0b0001100, nrs_id, FPR32, [FPR32, FPR32], int_prefix_str # "_sgnjx", "sgnjx">;

  def _SQRT : NRSSLInstrUnary<0b0000100, nrs_id, FPR32, FPR32, int_prefix_str # "_sqrt", "fsqrt">;

  let IsSignExtendingOpW = 1 in
    def _CVT_TO_INT: NRSSLInstrUnary<0b0001101, nrs_id, GPR, FPR32, int_prefix_str # "_cvtToInt", "cvtToInt">;
  let IsSignExtendingOpW = 1 in
    def _CVT_TO_UINT: NRSSLInstrUnary<0b0001101, nrs_id, GPR, FPR32, int_prefix_str # "_cvtToUInt", "cvtToUInt", 0b00001>;

  def _CVT_FROM_INT : NRSSLInstrUnary<0b0001110, nrs_id, FPR32, GPR, int_prefix_str # "_cvtFromInt", "cvtFromInt">;
  def _CVT_FROM_UINT : NRSSLInstrUnary<0b0001110, nrs_id, FPR32, GPR, int_prefix_str # "_cvtFromUInt", "cvtFromUInt", 0b00001>;
}

class NRSSL_NRS<bits<3> id_, string int_name_> {
  bits<3> id = id_;
  string name = NAME;
  string int_name = int_name_;
}

def MORRIS       : NRSSL_NRS<0b000, "morris">;
def MORRIS_HEB    : NRSSL_NRS<0b001, "morrisHeb">;
def MORRIS_BIAS_HEB: NRSSL_NRS<0b010, "morrisBiasHeb">;
def POSIT1       : NRSSL_NRS<0b011, "posit1">;
def POSIT2       : NRSSL_NRS<0b100, "posit2">;
def MORRIS_UNARY_HEB : NRSSL_NRS<0b101, "morrisUnaryHeb">;

defvar nrssl_nrs = [
  MORRIS,
  MORRIS_HEB,
  MORRIS_BIAS_HEB,
  POSIT1,
  POSIT2,
  MORRIS_UNARY_HEB
];

foreach nrs = nrssl_nrs in {
  defvar int_prefix_str = "int_riscv_nrssl_f32_" # nrs.int_name;
  defm NRSSL_F32_ # nrs.name : NRSSLOpGroup<nrs.id, int_prefix_str>;
}
