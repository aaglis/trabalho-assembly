.data
prompt:      .asciiz "Digite a quantidade de segundos: "
result_msg:  .asciiz "Resultado: "
newline:     .asciiz "\n"
days_msg:    .asciiz " Dias, "
hours_msg:   .asciiz " Horas, "
minutes_msg: .asciiz " Minutos, "
seconds_msg: .asciiz " Segundos\n"

.text
main:
    # Imprime o prompt para o usuário
    li $v0, 4              # syscall para print_string
    la $a0, prompt         # endereço da string de prompt
    syscall

    # Lê a entrada do usuário (número de segundos)
    li $v0, 5              # syscall para read_int
    syscall
    move $t0, $v0          # armazena o número de segundos em $t0

    # Calcula dias
    li $t1, 86400          # segundos em um dia
    divu $t2, $t0, $t1    # divide $t0 por $t1; resultado em $t2 (dias)
    mflo $t2               # move o quociente para $t2 (dias)
    mfhi $t3               # move o resto para $t3 (segundos restantes)

    # Calcula horas
    li $t1, 3600           # segundos em uma hora
    divu $t4, $t3, $t1    # divide $t3 por $t1; resultado em $t4 (horas)
    mflo $t4               # move o quociente para $t4 (horas)
    mfhi $t3               # move o resto para $t3 (segundos restantes)

    # Calcula minutos
    li $t1, 60             # segundos em um minuto
    divu $t5, $t3, $t1    # divide $t3 por $t1; resultado em $t5 (minutos)
    mflo $t5               # move o quociente para $t5 (minutos)
    mfhi $t3               # move o resto para $t3 (segundos restantes)

    # Imprime a mensagem de resultado
    li $v0, 4              # syscall para print_string
    la $a0, result_msg     # endereço da string de resultado
    syscall

    # Imprime o número de dias
    li $v0, 1              # syscall para print_int
    move $a0, $t2          # número de dias a ser impresso
    syscall

    # Imprime " dias, "
    li $v0, 4
    la $a0, days_msg
    syscall

    # Imprime o número de horas
    li $v0, 1
    move $a0, $t4          # número de horas a ser impresso
    syscall

    # Imprime " horas, "
    li $v0, 4
    la $a0, hours_msg
    syscall

    # Imprime o número de minutos
    li $v0, 1
    move $a0, $t5          # número de minutos a ser impresso
    syscall

    # Imprime " minutos, "
    li $v0, 4
    la $a0, minutes_msg
    syscall

    # Imprime o número de segundos
    li $v0, 1
    move $a0, $t3          # número de segundos a ser impresso
    syscall

    # Imprime " segundos\n"
    li $v0, 4
    la $a0, seconds_msg
    syscall

    # Finaliza o programa
    li $v0, 10             # syscall para exit
    syscall
