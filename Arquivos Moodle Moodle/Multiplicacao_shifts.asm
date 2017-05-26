# 
# Exercicio: multiplicar dois numeros usando o seguinte procedimento:
# 
# 1. Carrega o valor de A em $s0
# 2. Carrega o valor de B em $s1
# 3. Zera o registrador $s2 que contera o resultado (usar xor)
# 4. Carrega o registrador $t0 com 1, para servir como mascara de comparacao
# 	do bit menos significativo do multiplicador
# 
# 5. Verifica se B ($s1) eh zero. 
#         5.1. Se afirmativo, terminou a multiplicacao, salta para passo 10
# 
# 6. Senao, verifica se o bit menos significativo de B ($s1) e' igual a '1' ($t0)
#         6.1 Se afirmativo acumula o resultado ($s2) com A ($s0)
# 
# 7. Senão, desloca B ($s1) um bit para a direita
# 8. Desloca A ($s0) um bit para a esquerda
# 
# 9. Volta para 5
# 
# 10. Grava o conteudo de $s2 no endereco res
# 
  .data
 A:      .word    0x012ABC	# 
 B:      .word    0x004A5F	# 
res:    .word    0x00       	# 

  .text
  .globl main
  
main:
                        
        la      $s0, A  
        lw      $s0, 0($s0)     # multiplicador 
        
        
        la      $s1, B  
        lw      $s1, 0($s1)     # multiplicando
	
	
        xor     $s2, $s2, $s2   # zera o resultado
               
        la      $t0, 1          # mascara para comparacao

  
loop:   beq     $s1,$zero, fim  # quando o multiplicador ($s1) atingir zero, terminou a multiplicacao
 
        and     $t1,$s1,$t0     # verifica se o bit menos significativo do multiplicador ($s1) e' igual a '1' ($t0)

        bne     $t1,$zero, soma 
        
volta:  srl     $s1,$s1,1       # desloca para direita o multiplicador  
        sll     $s0,$s0,1       # desloca para esquerda o resultado parcial da multiplicacao

        j       loop
        
soma:	
	addu    $s2, $s2, $s0
        j       volta
        
fim:    la      $t0, res
        sw      $s2, 0($t0)
         
aqui:      j       aqui		# Outra forma de "parar" o programa eh entrar em loop eterno!!!
