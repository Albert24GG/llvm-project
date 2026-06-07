// NRSSL Instruction definitions

def NRSSL_OPC : RISCVOpcode<"NRSSL", 0b0001011>;

class NRSSLInstr<bits<7> op, bits<3> nrs_id, string int_str, string opstr> :
    RVInstR< 
        op,
        nrs_id,
        NRSSL_OPC,
        (outs FPR32:$rd),
        (ins FPR32:$rs1, FPR32:$rs2),
        opstr,
        "$rd, $rs1, $rs2"> {

  let Pattern = [
    (
      set FPR32:$rd,
      (!cast<NRSSL_F32_Instr> (int_str) FPR32:$rs1, FPR32:$rs2)
    )
  ];

  let mayStore = 0;
  let mayLoad = 0;
  let hasSideEffects = 0;
}

multiclass NRSSLOpGroup<bits<3> nrs_id, string int_prefix_str> {
  def _ADD : NRSSLInstr<0b0000000, nrs_id, int_prefix_str # "_add", "fadd">;
  def _SUB : NRSSLInstr<0b0000001, nrs_id, int_prefix_str # "_sub", "fsub">;
  def _MUL : NRSSLInstr<0b0000010, nrs_id, int_prefix_str # "_mul", "fmul">;
  def _DIV : NRSSLInstr<0b0000011, nrs_id, int_prefix_str # "_div", "fdiv">;
  def _SQRT : NRSSLInstr<0b0000100, nrs_id, int_prefix_str # "_sqrt", "fsqrt">;
  def _EQ : NRSSLInstr<0b0000101, nrs_id, int_prefix_str # "_eq", "feq">;
  def _LT : NRSSLInstr<0b0000110, nrs_id, int_prefix_str # "_lt", "flt">;
  def _LE : NRSSLInstr<0b0000111, nrs_id, int_prefix_str # "_le", "fle">;
  def _MIN : NRSSLInstr<0b0001000, nrs_id, int_prefix_str # "_min", "fmin">;
  def _MAX : NRSSLInstr<0b0001001, nrs_id, int_prefix_str # "_max", "fmax">;
  def _SGNJ : NRSSLInstr<0b0001010, nrs_id, int_prefix_str # "_sgnj", "sgnj">;
  def _SGNJN : NRSSLInstr<0b0001011, nrs_id, int_prefix_str # "_sgnjn", "sgnjn">;
  def _SGNJX : NRSSLInstr<0b0001100, nrs_id, int_prefix_str # "_sgnjx", "sgnjx">;
  def _CVT_TO_INT : NRSSLInstr<0b0001101, nrs_id, int_prefix_str # "_cvtToInt", "cvtToInt">;
  def _CVT_FROM_INT : NRSSLInstr<0b0001110, nrs_id, int_prefix_str # "_cvtFromInt", "cvtFromInt">;
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
