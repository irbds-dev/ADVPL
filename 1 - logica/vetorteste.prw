#include "protheus.ch"

user function vetorteste()
    local nCount
    local aVetor1 := {"banana", "maca", "laranja"}

    local aVetor2 := ACLONE(aVetor1)

    Asize(aVetor2, 1)

    for nCount := 1 TO 3
        alert(aVetor2[nCount])
    next
return
