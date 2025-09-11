/*
the ALU control unit generates the 4-bit signal that controls the ALU
it takes as input funct7, funct3, and the two bit alu_op signal from the main
control unit
*/

module alu_control(
    input [6:0] opcode,
    input [6:0] funct7,
    input [2:0] funct3,
    input [1:0] alu_op,
    output reg [3:0] alu_control
);

always @ (*) begin
    case (alu_op)
        2'b00: alu_control = 4'b0010; //sw,lw -> add
        2'b01: alu_control = 4'b0110; //beq -> sub
        2'b10: begin //R-Type or I-type ALU

            case (funct3)
                3'b000: begin
                    if (funct7 == 7'b0100000 && opcode == 7'b0110011)
                        alu_control = 4'b0110; // SUB (R-type only) *
                    else
                        alu_control = 4'b0010; // ADD / ADDI *
                end
                3'b010: alu_control = 4'b0111; //slt
                3'b110: alu_control = 4'b0001; //or
                3'b111: alu_control = 4'b0000; //and
                default: alu_control = 4'b0000;
            endcase

        end

        default: alu_control = 4'b0000;
    endcase
end

endmodule 