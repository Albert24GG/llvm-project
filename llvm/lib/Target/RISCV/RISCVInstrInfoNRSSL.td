// NRSSL Instruction definitions

def OPC_NRSSL      : RISCVOpcode<"NRSSL",      0b0001011>;

class NRSSLInstr<bits<7> op, bits<3> nrs_id, string opstr> :
    RVInstR< 
        op,
        nrs_id,
        OPC_NRSSL,
        (outs FPR32:$rd),
        (ins FPR32:$rs1, FPR32:$rs2),
        opstr,
        "$rd, $rs1, $rs2"> {

  let mayStore = 0;
  let mayLoad = 0;
  let hasSideEffects = 0;
}


class NRS<bits<3> id_, string name_> {
  bits<3> id = id_;
  string name = name_;
}

def Morris       : NRS<0b000, "Morris">;
def MorrisHEB    : NRS<0b001, "MorrisHEB">;
def MorrisBiasHEB: NRS<0b010, "MorrisBiasHEB">;
def Posit1       : NRS<0b011, "Posit1">;
def Posit2       : NRS<0b100, "Posit2">;
def MorrisUnaryHEB : NRS<0b101, "MorrisUnaryHEB">;

foreach nrs = [
  Morris,
  MorrisHEB,
  MorrisBiasHEB,
  Posit1,
  Posit2,
  MorrisUnaryHEB
]
in {
  def NRSSL_FAdd_ # nrs.name : NRSSLInstr<0b0000000, nrs.id, "fadd.s">;
}


// Pattern matching between the instruction and the IR

def : Pat<
  (int_posit_f32_add FPR32:$rs1, FPR32:$rs2),
  (NRSSL_FAdd_Posit1 FPR32:$rs1, FPR32:$rs2)
>;
