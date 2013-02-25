import sys
from bitstring import BitArray

opcodes = {"add":{"op":"0000", "type":"r"},
           "sub":{"op":"0001", "type":"r"},
           "and":{"op":"0010", "type":"r"},
           "or":{"op":"0011", "type":"r"},
           "addi":{"op":"0100", "type":"i"},
           "lw":{"op":"0101", "type":"i"},
           "sw":{"op":"0110", "type":"i"},
           "slt":{"op":"0111", "type":"r"},
           "beq":{"op":"1000", "type":"i"},
           "bne":{"op":"1001", "type":"i"}}

registers = {"$0":"00", "$1":"01", "$2":"10", "$3":"11"}

if __name__ == "__main__":
    location = 0
    in_file = open(sys.argv[1], 'r')
    for line in in_file:
        line = line[:line.find('#')].strip()
        if not line or line.find(':') != -1 or line[0] == '.':
            continue
        opcode = ''
        rs = ''
        rt = ''
        rd = ''
        value = ''
        bin_line = ''
        tokens = line.lower().split(' ')
        tokens = tokens[:1] + ''.join(tokens[1:]).split(',')
        print(tokens)
        opcode = opcodes[tokens[0]]["op"]
        rs = registers[tokens[2]]
        if opcodes[tokens[0]]["type"] == "r":
            rd = registers[tokens[1]]
            rt = registers[tokens[3]]
            value = "000000"
        else:
            # i-type
            value = BitArray(int=int(tokens[-1]), length=8).bin
            rt = registers[tokens[1]]
        #for token in tokens:
            #if token in opcodes:
                #bin_line = bin_line + opcodes[token]
            #elif token in registers:
                #bin_line += registers[token]
            #else:
                #bin_line += BitArray(int=int(token), length=8).bin
        bin_line = ''.join((opcode, rs, rt, rd, value))
        print(bin_line)
        hex_line = BitArray("0b" + bin_line).hex
        print(hex_line)
        print("IMemory[{}] = 16'h{};\t// {}".format(location, hex_line, line.lower()))
        location += 1
