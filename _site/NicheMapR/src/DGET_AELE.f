      SUBROUTINE DGET_AELE(N,A,AELE,DAELE,RPAR,IPAR)

C     NICHEMAPR: SOFTWARE FOR BIOPHYSICAL MECHANISTIC NICHE MODELLING

C     COPYRIGHT (C) 2018 MICHAEL R. KEARNEY AND WARREN P. PORTER

C     THIS PROGRAM IS FREE SOFTWARE: YOU CAN REDISTRIBUTE IT AND/OR MODIFY
C     IT UNDER THE TERMS OF THE GNU GENERAL PUBLIC LICENSE AS PUBLISHED BY
C     THE FREE SOFTWARE FOUNDATION, EITHER VERSION 3 OF THE LICENSE, OR (AT
C      YOUR OPTION) ANY LATER VERSION.

C     THIS PROGRAM IS DISTRIBUTED IN THE HOPE THAT IT WILL BE USEFUL, BUT
C     WITHOUT ANY WARRANTY; WITHOUT EVEN THE IMPLIED WARRANTY OF
C     MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. SEE THE GNU
C     GENERAL PUBLIC LICENSE FOR MORE DETAILS.

C     YOU SHOULD HAVE RECEIVED A COPY OF THE GNU GENERAL PUBLIC LICENSE
C     ALONG WITH THIS PROGRAM. IF NOT, SEE HTTP://WWW.GNU.ORG/LICENSES/.

C     EQUATIONS TO COMPUTE RATES OF CHANGE IN RESERVE, STRUCTURAL LENGTH AND REPRODUCTION BUFFER FOR AN INSECT

      IMPLICIT NONE
      INTEGER IPAR,N
      DOUBLE PRECISION A,AELE,DAELE,DE,DE_R,DER,DL,E,E_M,E_R,E_S,F,G
      DOUBLE PRECISION K_E,K_M,KAP,L,P_AM,P_C,P_J,R,RPAR,V
      DIMENSION AELE(N),DAELE(N),IPAR(13),RPAR(13)

      F=RPAR(1)
      K_M=RPAR(2)
      K_E=RPAR(3)
      P_J=RPAR(4)
      P_AM=RPAR(5)
      E_M=RPAR(6)
      G=RPAR(7)
      KAP=RPAR(8)
      A  = AELE(1)! % D, TIME SINCE BIRTH
      E  = AELE(2)! % J, RESERVE
      L  = AELE(3)! % CM, STRUCTURAL LENGTH
      E_R= AELE(4)! % J, REPRODUCTION BUFFER
      E_R= AELE(5)! % J, REPRODUCTION BUFFER

      V = L**3.D+00                          ! CM^3, STRUCTURAL VOLUME
      E_S = E/ V/ E_M                    ! -, SCALED RESERVE DENSITY
      R = (E_S * K_E - G * K_M)/ (E_S + G) ! 1/D, SPECIFIC GROWTH RATE
      P_C = E * (K_E - R)              ! J/D, MOBILISATION RATE

      DE = F * P_AM * V - P_C          ! J/D, CHANGE IN RESERVE
      DL = R * L/ 3.D+00                   ! CM/D, CHANGE IN LENGTH
      DE_R = (1.D+00 - KAP) * P_C - P_J     ! J/D, CHANGE IN REPROD BUFFER
      DER = DE_R/ V - R * (E_R/ V)       ! J/D.CM^3, CHANGE IN [E_R]

      DAELE(1)=1.0D+00
      DAELE(2)=DE
      DAELE(3)=DL
      DAELE(4)=DE_R
      DAELE(5)=DE_R

      RETURN
      END