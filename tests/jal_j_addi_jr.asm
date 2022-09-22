addi $2, $2, 1
jal procedure
j end
addi $1, $1, 10
procedure: addi $2, $1, 10
addi $1, $2, 5
add $1, $2, $2
jr $ra
end: nop