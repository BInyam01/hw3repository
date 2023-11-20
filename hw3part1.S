.globl main
.data
sx: .word 1,2,3,4,5
sy: .word 5,4,3,2,1
.text
.ent main
main:
li $a0,2      # Load arguments to $a0,$a1,$a2
li $a1,1
li $a2,1
jal g         # Call procedure from main
loop:
j loop 
nop 
.end main 
.ent g
g: 
bne $a1,1,test2     # If incx!=1, branch to test2
bne $a2,1,test2     # If incy!=1, branch to test2 

test1:              # If incx=1 and incy=1
li $s0,0            # Let i be $s0 initialized to 0
loop1:
la $t0,sx           # Load address of sx to $t0
la $t1,sy           # Load address of sy to $t1
sll $t2,$s0,2       # $t2=4*i
add $t0,$t0,$t2     # $t0 contain address of sx[i]
add $t1,$t1,$t2     # $t1 contain address of sy[i]
lw $s1,0($t0)       # Load sx[i] to $s1
lw $s2,0($t1)       # Load sy[i] to $s2
mul $s1,$s1,$a0     # Multiply $s1 with $a0, so $s1=sa*sx[i]
add $s2,$s2,$s1     # Add sy[i] with sa*sx[i]
sw $s2,0($t1)       # Store sy[i]+ sa*sx[i] in sy[i]. So, sy[i]=sy[i]+ sa*sx[i]
addi $s0,$s0,1      # Increment i 
beq $s0,5,Return    # if i=5 branch to Return 
b loop1             # If i<5 branch to loop1


test2:               # if incx!=1 or inc2!=1
li $t0,0            # i=0
li $t1,0            # ix=0
li $t2,0            # iy=0


loop2:
la $t3,sx           # Load address of sx to $t3
la $t4,sy           # Load address of sy to $t4
sll $t5,$t1,2       # $t5 =ix*4
sll $t6,$t2,2       # $t6 =iy*4
add $t3,$t3,$t5     # Add $t5 with $t3, so $t3 contain address of sx[ix] 
add $t4,$t4,$t6     # Add $t6 with $t4, so $t4 contain address of sy[iy] 
lw $s0,0($t3)       # Load s[ix] to $s0
lw $s1,0($t4)       # Load s[iy] to $s1
mul $s0,$s0,$a0     # Multiply $s0 with $a0, so $s0=sa*sx[ix]
add $s1,$s1,$s0     # Add sy[iy] with sa*sx[ix]
sw $s0,0($t4)       # Store sy[iy]+ sa*sx[ix] in sy[iy]. So, sy[iy]=sy[iy]+ sa*sx[ix]
add $t1,$t1,$a1     # Add $t0 with $a1, so ix=ix+incx
add $t2,$t2,$a2     # Add $t1 with $a2, so iy=iy+incy
addi $t0,$t0,1      # increment i
beq $t0,10,Return   # if i=10 branch to Return 
b loop2             # If i<10 branch to loop2

Return: 
jr $ra             # Return from procedure 
nop
.end g