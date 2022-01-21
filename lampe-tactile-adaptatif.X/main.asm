;*******************************************************************************
;                                                                              *
;    Microchip licenses this software to you solely for use with Microchip     *
;    products. The software is owned by Microchip and/or its licensors, and is *
;    protected under applicable copyright laws.  All rights reserved.          *
;                                                                              *
;    This software and any accompanying information is for suggestion only.    *
;    It shall not be deemed to modify Microchip?s standard warranty for its    *
;    products.  It is your responsibility to ensure that this software meets   *
;    your requirements.                                                        *
;                                                                              *
;    SOFTWARE IS PROVIDED "AS IS".  MICROCHIP AND ITS LICENSORS EXPRESSLY      *
;    DISCLAIM ANY WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING  *
;    BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS    *
;    FOR A PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL          *
;    MICROCHIP OR ITS LICENSORS BE LIABLE FOR ANY INCIDENTAL, SPECIAL,         *
;    INDIRECT OR CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, HARM TO     *
;    YOUR EQUIPMENT, COST OF PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR    *
;    SERVICES, ANY CLAIMS BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY   *
;    DEFENSE THEREOF), ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER      *
;    SIMILAR COSTS.                                                            *
;                                                                              *
;    To the fullest extend allowed by law, Microchip and its licensors         *
;    liability shall not exceed the amount of fee, if any, that you have paid  *
;    directly to Microchip to use this software.                               *
;                                                                              *
;    MICROCHIP PROVIDES THIS SOFTWARE CONDITIONALLY UPON YOUR ACCEPTANCE OF    *
;    THESE TERMS.                                                              *
;                                                                              *
;*******************************************************************************
;                                                                              *
;    Filename:                 lampe-tactile-adaptatif                         *
;    Date:                     January 21, 2022                                *
;    File Version:             v1.0.0                                          *
;    Author:                   Dorian LAROUZIERE & Gatien VILAIN               *
;    Company:                  ---                                             *
;    Description:                                                              *
;                                                                              *
;*******************************************************************************
;                                                                              *
;    Notes: In the MPLAB X Help, refer to the MPASM Assembler documentation    *
;    for information on assembly instructions.                                 *
;                                                                              *
;*******************************************************************************
;                                                                              *
;    Known Issues: This template is designed for relocatable code.  As such,   *
;    build errors such as "Directive only allowed when generating an object    *
;    file" will result when the 'Build in Absolute Mode' checkbox is selected  *
;    in the project properties.  Designing code in absolute mode is            *
;    antiquated - use relocatable mode.                                        *
;                                                                              *
;*******************************************************************************
;                                                                              *
;    Revision History:                                                         *
;                                                                              *
;*******************************************************************************



;*******************************************************************************
; Processor Inclusion
;
; TODO Step #1 Open the task list under Window > Tasks.  Include your
; device .inc file - e.g. #include <device_name>.inc.  Available
; include files are in C:\Program Files\Microchip\MPLABX\mpasmx
; assuming the default installation path for MPLAB X.  You may manually find
; the appropriate include file for your device here and include it, or
; simply copy the include generated by the configuration bits
; generator (see Step #2).
;
;*******************************************************************************

; TODO INSERT INCLUDE CODE HERE

;*******************************************************************************
;
; TODO Step #2 - Configuration Word Setup
;
; The 'CONFIG' directive is used to embed the configuration word within the
; .asm file. MPLAB X requires users to embed their configuration words
; into source code.  See the device datasheet for additional information
; on configuration word settings.  Device configuration bits descriptions
; are in C:\Program Files\Microchip\MPLABX\mpasmx\P<device_name>.inc
; (may change depending on your MPLAB X installation directory).
;
; MPLAB X has a feature which generates configuration bits source code.  Go to
; Window > PIC Memory Views > Configuration Bits.  Configure each field as
; needed and select 'Generate Source Code to Output'.  The resulting code which
; appears in the 'Output Window' > 'Config Bits Source' tab may be copied
; below.
;
;*******************************************************************************

; TODO INSERT CONFIG HERE

;*******************************************************************************
;
; TODO Step #3 - Variable Definitions
;
; Refer to datasheet for available data memory (RAM) organization assuming
; relocatible code organization (which is an option in project
; properties > mpasm (Global Options)).  Absolute mode generally should
; be used sparingly.
;
; Example of using GPR Uninitialized Data
;
;   GPR_VAR        UDATA
;   MYVAR1         RES        1      ; User variable linker places
;   MYVAR2         RES        1      ; User variable linker places
;   MYVAR3         RES        1      ; User variable linker places
;
;   ; Example of using Access Uninitialized Data Section (when available)
;   ; The variables for the context saving in the device datasheet may need
;   ; memory reserved here.
;   INT_VAR        UDATA_ACS
;   W_TEMP         RES        1      ; w register for context saving (ACCESS)
;   STATUS_TEMP    RES        1      ; status used for context saving
;   BSR_TEMP       RES        1      ; bank select used for ISR context saving
;
;*******************************************************************************

; TODO PLACE VARIABLE DEFINITIONS GO HERE

INT_VAR        UDATA_ACS
compteur    RES	    1
resultat    RES	    1
var0	RES	1
var1	RES	1
var2	RES	1
mode	RES	1

;*******************************************************************************
; Reset Vector
;*******************************************************************************

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    DEBUT                   ; go to beginning of program

;*******************************************************************************
; TODO Step #4 - Interrupt Service Routines
;
; There are a few different ways to structure interrupt routines in the 8
; bit device families.  On PIC18's the high priority and low priority
; interrupts are located at 0x0008 and 0x0018, respectively.  On PIC16's and
; lower the interrupt is at 0x0004.  Between device families there is subtle
; variation in the both the hardware supporting the ISR (for restoring
; interrupt context) as well as the software used to restore the context
; (without corrupting the STATUS bits).
;
; General formats are shown below in relocatible format.
;
;------------------------------PIC16's and below--------------------------------
;
; ISR       CODE    0x0004           ; interrupt vector location
;
;     <Search the device datasheet for 'context' and copy interrupt
;     context saving code here.  Older devices need context saving code,
;     but newer devices like the 16F#### don't need context saving code.>
;
;     RETFIE
;
;----------------------------------PIC18's--------------------------------------
;
; ISRHV     CODE    0x0008
;     GOTO    HIGH_ISR
; ISRLV     CODE    0x0018
;     GOTO    LOW_ISR
;
; ISRH      CODE                     ; let linker place high ISR routine
; HIGH_ISR
;     <Insert High Priority ISR Here - no SW context saving>
;     RETFIE  FAST
;
; ISRL      CODE                     ; let linker place low ISR routine
; LOW_ISR
;       <Search the device datasheet for 'context' and copy interrupt
;       context saving code here>
;     RETFIE
;
;*******************************************************************************

; TODO INSERT ISR HERE

ISRHV     CODE    0x0008
    INCF mode ;On incr�mente la variable mode � chaque interruption hardware
    MOVLW d'4'
    CPFSLT mode ;Si mode <4 skip
    CLRF mode ;On passe mode � 0
    BANKSEL PIR0 ;On place dans le BSR la banque qui contient le registre PIR0
    BCF PIR0, INT0IF ;On met � 0 le flag d'interruption
    RETFIE FAST

;*******************************************************************************
; MAIN PROGRAM
;*******************************************************************************


; PIC18F25K40 Configuration Bit Settings

; Assembly source line config statements

#include "p18f25k40.inc"

; CONFIG1L
  CONFIG  FEXTOSC = OFF         ; External Oscillator mode Selection bits (Oscillator not enabled)
  CONFIG  RSTOSC = HFINTOSC_64MHZ; Power-up default value for COSC bits (HFINTOSC with HFFRQ = 4 MHz and CDIV = 4:1)

; CONFIG1H
  CONFIG  CLKOUTEN = ON        ; Clock Out Enable bit (CLKOUT function is disabled)
  CONFIG  CSWEN = ON            ; Clock Switch Enable bit (Writing to NOSC and NDIV is allowed)
  CONFIG  FCMEN = ON            ; Fail-Safe Clock Monitor Enable bit (Fail-Safe Clock Monitor enabled)

; CONFIG2L
  CONFIG  MCLRE = EXTMCLR       ; Master Clear Enable bit (If LVP = 0, MCLR pin is MCLR; If LVP = 1, RE3 pin function is MCLR )
  CONFIG  PWRTE = OFF           ; Power-up Timer Enable bit (Power up timer disabled)
  CONFIG  LPBOREN = OFF         ; Low-power BOR enable bit (ULPBOR disabled)
  CONFIG  BOREN = SBORDIS       ; Brown-out Reset Enable bits (Brown-out Reset enabled , SBOREN bit is ignored)

; CONFIG2H
  CONFIG  BORV = VBOR_2P45      ; Brown Out Reset Voltage selection bits (Brown-out Reset Voltage (VBOR) set to 2.45V)
  CONFIG  ZCD = OFF             ; ZCD Disable bit (ZCD disabled. ZCD can be enabled by setting the ZCDSEN bit of ZCDCON)
  CONFIG  PPS1WAY = ON          ; PPSLOCK bit One-Way Set Enable bit (PPSLOCK bit can be cleared and set only once; PPS registers remain locked after one clear/set cycle)
  CONFIG  STVREN = ON           ; Stack Full/Underflow Reset Enable bit (Stack full/underflow will cause Reset)
  CONFIG  DEBUG = OFF           ; Debugger Enable bit (Background debugger disabled)
  CONFIG  XINST = OFF           ; Extended Instruction Set Enable bit (Extended Instruction Set and Indexed Addressing Mode disabled)

; CONFIG3L
  CONFIG  WDTCPS = WDTCPS_31    ; WDT Period Select bits (Divider ratio 1:65536; software control of WDTPS)
  CONFIG  WDTE = OFF            ; WDT operating mode (WDT Disabled)

; CONFIG3H
  CONFIG  WDTCWS = WDTCWS_7     ; WDT Window Select bits (window always open (100%); software control; keyed access not required)
  CONFIG  WDTCCS = SC           ; WDT input clock selector (Software Control)

; CONFIG4L
  CONFIG  WRT0 = OFF            ; Write Protection Block 0 (Block 0 (000800-001FFFh) not write-protected)
  CONFIG  WRT1 = OFF            ; Write Protection Block 1 (Block 1 (002000-003FFFh) not write-protected)
  CONFIG  WRT2 = OFF            ; Write Protection Block 2 (Block 2 (004000-005FFFh) not write-protected)
  CONFIG  WRT3 = OFF            ; Write Protection Block 3 (Block 3 (006000-007FFFh) not write-protected)

; CONFIG4H
  CONFIG  WRTC = OFF            ; Configuration Register Write Protection bit (Configuration registers (300000-30000Bh) not write-protected)
  CONFIG  WRTB = OFF            ; Boot Block Write Protection bit (Boot Block (000000-0007FFh) not write-protected)
  CONFIG  WRTD = OFF            ; Data EEPROM Write Protection bit (Data EEPROM not write-protected)
  CONFIG  SCANE = ON            ; Scanner Enable bit (Scanner module is available for use, SCANMD bit can control the module)
  CONFIG  LVP = OFF             ; Low Voltage Programming Enable bit (HV on MCLR/VPP must be used for programming)

; CONFIG5L
  CONFIG  CP = OFF              ; UserNVM Program Memory Code Protection bit (UserNVM code protection disabled)
  CONFIG  CPD = OFF             ; DataNVM Memory Code Protection bit (DataNVM code protection disabled)

; CONFIG5H

; CONFIG6L
  CONFIG  EBTR0 = OFF           ; Table Read Protection Block 0 (Block 0 (000800-001FFFh) not protected from table reads executed in other blocks)
  CONFIG  EBTR1 = OFF           ; Table Read Protection Block 1 (Block 1 (002000-003FFFh) not protected from table reads executed in other blocks)
  CONFIG  EBTR2 = OFF           ; Table Read Protection Block 2 (Block 2 (004000-005FFFh) not protected from table reads executed in other blocks)
  CONFIG  EBTR3 = OFF           ; Table Read Protection Block 3 (Block 3 (006000-007FFFh) not protected from table reads executed in other blocks)

; CONFIG6H
  CONFIG  EBTRB = OFF           ; Boot Block Table Read Protection bit (Boot Block (000000-0007FFh) not protected from table reads executed in other blocks)


MAIN_PROG CODE                      ; let linker place main program

SETUP_PORTA
    ;RA0 : signal du filtre (entr�e)
    CLRF ANSELA
    MOVLW   b'00000001'
    MOVWF   TRISA
    RETURN

SETUP_PORTC
    ;RC4 � RC7 : leds de test (sortie)
    ;RC2 : enable microchip (sortie)
    ;RC1 : microchip out analogique, pour r�gler la sensibilit� (sortie)
    BANKSEL ANSELC ;On place dans le BSR la banque qui contient le registre PIR0
    CLRF ANSELC ; On active les entr�e num�rique sur le port C
    MOVLW   b'00000000'
    MOVWF   TRISC
    RETURN

SETUP_PORTB
    ;RB6 et RB7 : PGC et PGD (entr�es)
    ;RB5 : commande des leds RBG (sortie)
    ;RB0 : sortie microchip (entr�e)
    BANKSEL ANSELB
    CLRF ANSELB
    MOVLW   b'00000001'
    MOVWF   TRISB
    RETURN


INIT_LEDS_TESTS
    MOVF LATC,0 ;On copie le contenu de LATC dans l'accumulateur
    ANDLW b'00001111' ;On applique un masque pour ne modifiers que les 4 bits de poids forts (on passe � 0)
    MOVWF LATC
    RETURN


SETUP_INTERRUPTION
    BANKSEL PIE0 ;
    BSF PIE0, INT0IE ;On active les interruptions externes sur le pin0
    BCF INTCON,INT0EDG ;Interruption sur front descendant 
    BSF IPR0, INT0IP ;On passe l'interruption du bouton en haute priorit� 
    BCF PIR0, INT0IF ;On passe le flag de l'interruption � 0
    CLRF PIR0
    BSF INTCON, GIE ;On active toutes les interruptions
    RETURN

SETUP_BUTTON
    BSF LATC, 2 ; active en mode normal le driver capacitif
    RETURN

SETUP_PWM
    MOVLB 0x0E ;On place le BSR � la banque 14
    MOVLW b'00000110' 
    MOVWF RC1PPS ;On s�lectionne la source de sortie (CCP2)
    MOVLW d'100'
    MOVWF T2PR ;On initialise la valeur max pour le timer2
    MOVLW b'10001100'
    MOVWF CCP2CON ;On active le module CCP, et on aligne � droite pour le mode PWM
    MOVLW d'50'
    MOVWF CCPR2L ;On initialise la valeur seuil pour le timer2
    CLRF  CCPR2H

    ;SETUP TIMER2
    BCF PIR4, TMR2IF ;On passe � 0 le flag d'interruption du time2
    MOVLW b'00000001'
    MOVWF T2CLKCON ;On s�lectionne comme source d'horloge pour le timer2 : Fosc/4
    MOVLW b'11000000'
    MOVWF T2CON ;Initialisation du timer2 : timer2 = ON , prescaler = 16, postscaler = 1
    RETURN


SETUP_ADC
	; d�but de la configuration
    MOVLB 0x0F ; s�lection de la banque d'adresse
    MOVLW b'00000000'
    MOVWF ADPCH, 1 ; s�lection du channel ADC (ANA0)
    MOVLW b'00010000'
    MOVWF ADREF, 1 ; configuration des r�f�rences analogiques
    MOVLW b'00001111' ; Fosc/80
    MOVWF ADCLK, 1 ; configuration de l?horloge de l?ADC : 1�s ? TAD ? 6�s
    MOVLW b'11111111'
    MOVWF ADPRE, 1 ; configuration du temps de pr�charge (max. par d�faut)
    MOVWF ADACQ, 1 ; configuration du temps d'acquisition (max. par d�faut)
    CLRF ADCAP, 1 ; pas de capacit� additionnelle
    MOVLW b'00000000'
    MOVWF ADACT, 1 ; pas d?activation auto. de l'ADC sur �v�nement 
    MOVLW b'00000000'
    MOVWF ADCON3, 1 ; pas d?interruption sur l'ADC
    MOVLW b'00000000'
    MOVWF ADCON2, 1 ; configuration de l'ADC en mode basique
    MOVLW b'00000000'
    MOVWF ADCON1, 1 ; configuration des options de pr�charge
    MOVLW b'10000000';on aligne � gauche le r�sultat et on �teint ADC
    MOVWF ADCON0 ; configuration g�n�rale et format du r�sultat
   ; fin de la configuration
    RETURN

ACQUISITION
    BSF ADCON0, ADGO ;On la conversion par l'ADC du signal envoy� par la photoR�sistance
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    MOVFF ADRESH, resultat ;On r�cup�re la valeur de la photoR�sistance convertit en binaire
    RETURN


routine_tempo
    MOVLW   D'150'
    MOVWF   var0
    MOVWF   var1
    MOVWF   var2
    BOUCLE3
		DECFSZ	var2
		GOTO BOUCLE3
		MOVLW   D'150'
		MOVWF   var2
		GOTO BOUCLE2
    BOUCLE2
		DECFSZ	var1
		GOTO BOUCLE3
		MOVLW   D'150'
		MOVWF   var1
		GOTO BOUCLE1
    BOUCLE1
		DECFSZ	var0
		GOTO BOUCLE3
	return


BIT_A_0
    BSF	LATB, 5
    NOP
    NOP
    NOP
    NOP
    NOP
    BCF LATB, 5
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    RETURN

BIT_A_1
    BSF	LATB, 5 ;On envoie VDD sur la pate 5 du portB
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    BCF LATB, 5 ;On envoie VSS sur la patte 5 du port B
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    RETURN

MODE_CLIGNOTEMENT_LEDS
    MOVLW b'00100100';On active la led de contr�le 1
    MOVWF LATC
    BOUCLE_CLIGNOTEMENT
	MOVLW d'3'
	CPFSEQ mode ;Skip si mode = 3
	RETURN
	;Eteindre les leds
	MOVLW d'6'
	MOVWF compteur
	FOR2
	    ;Led verte
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    ;Led rouge
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    ;Led bleu
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    ;Led blanche
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_1
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	DECFSZ compteur
	GOTO FOR2
	CALL routine_tempo
    ;Allumer les leds
	MOVLW d'6'
	MOVWF compteur
	FOR3
	    ;Led verte
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    ;Led rouge
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    ;Led bleu
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    ;Led blanche
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    CALL BIT_A_0
	    DECFSZ compteur
	    GOTO FOR3
	    CALL routine_tempo
	GOTO BOUCLE_CLIGNOTEMENT
    RETURN

MODE_LUMIERE_VARIABLE
	MOVLW b'01000100' ;On active la led de contr�le 2
	MOVWF LATC
	BOUCLE_LUMIERE_VARIABLE
		MOVLW d'2'
		CPFSEQ mode ;Si mode = 2 --> skip
		RETURN
		CALL ACQUISITION
		MOVLW   d'100'
		CPFSGT	resultat ;Si resultat>100 --> skip
		GOTO LUMINOSITE_EXT_FAIBLE
		MOVLW   d'196'
		CPFSGT	resultat ;Si resultat>196 --> skip
		GOTO LUMINOSITE_EXT_MODEREE
		GOTO LUMINOSITE_EXT_ELEVEE
	    LUMINOSITE_EXT_FAIBLE
		MOVLW d'6'
		MOVWF compteur

		FOR_LUMINOSITE_EXT_FAIBLE
		    ;Led verte
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    ;Led rouge
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    ;Led bleu
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    ;Led blanche
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_1
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    DECFSZ compteur
		    GOTO FOR_LUMINOSITE_EXT_FAIBLE
		    ;CALL routine_tempo
		    ;CALL routine_tempo
		    CALL routine_tempo
		GOTO BOUCLE_LUMIERE_VARIABLE

	    LUMINOSITE_EXT_MODEREE
		MOVLW d'6'
		MOVWF compteur
		FOR_LUMINOSITE_EXT_MODEREE
		    ;Led verte
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    ;Led rouge
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    ;Led bleu
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    ;Led blanche
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_1
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    DECFSZ compteur
		    GOTO FOR_LUMINOSITE_EXT_MODEREE
		    ;CALL routine_tempo
		    ;CALL routine_tempo
		    CALL routine_tempo
		GOTO BOUCLE_LUMIERE_VARIABLE

	    LUMINOSITE_EXT_ELEVEE
		MOVLW d'6'
		MOVWF compteur
		FOR_LUMINOSITE_EXT_ELEVEE
		    ;Led verte
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    ;Led rouge
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    ;Led bleu
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    ;Led blanche
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_0
		    CALL BIT_A_1
		    DECFSZ compteur
		    GOTO FOR_LUMINOSITE_EXT_ELEVEE
		    CALL routine_tempo
		GOTO BOUCLE_LUMIERE_VARIABLE

MODE_LUMIERE_ON
    MOVLW d'1'
    CPFSEQ mode ;Si mode=1 skip
    RETURN
    MOVLW b'10000100';On active la led de contr�le 3
    MOVWF LATC;On allume la led verte sur le pin RC7
    MOVLW d'6'
    MOVWF compteur
    FOR_LUMIERE_ON
	;Led verte
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	;Led rouge
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	;Led bleu
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	;Led blanche
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_1
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	DECFSZ compteur
	GOTO FOR_LUMIERE_ON
    RETURN

MODE_LUMIERE_OFF
    MOVLW d'0'
    CPFSEQ mode
    RETURN
    MOVLW b'00000100';On d�sactive les leds de contr�les
    MOVWF LATC
    MOVLW d'6'
    MOVWF compteur
    FOR_LUMIERE_OFF
	;Led verte
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	;Led rouge
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	;Led bleu
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	;Led blanche
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	CALL BIT_A_0
	DECFSZ compteur
	GOTO FOR_LUMIERE_OFF
    RETURN


DEBUT
    ; TODO Step #5 - Insert Your Program Here
    CALL SETUP_PORTC
    CALL SETUP_PORTB
    CALL SETUP_PORTA
    CALL SETUP_ADC
    CALL SETUP_PWM
    CALL SETUP_INTERRUPTION
    CALL INIT_LEDS_TESTS
    CALL SETUP_BUTTON
    CLRF mode
    BOUCLE_MAIN
	TESTE_MODE0
	    CALL routine_tempo
	    ;CALL routine_tempo
	    MOVLW d'0'
	    CPFSEQ mode
	    GOTO TESTE_MODE1
	    CALL MODE_LUMIERE_OFF
	    ;CALL routine_tempo
	    ;INCF mode
	    GOTO BOUCLE_MAIN
	TESTE_MODE1
	    CALL routine_tempo
	    MOVLW d'1'
	    CPFSEQ mode
	    GOTO TESTE_MODE2
	    CALL MODE_LUMIERE_ON
	    ;CALL routine_tempo
	    ;INCF mode
	    GOTO BOUCLE_MAIN
	TESTE_MODE2
	    CALL routine_tempo
	    MOVLW d'2'
	    CPFSEQ mode
	    GOTO TESTE_MODE3
	    CALL MODE_LUMIERE_VARIABLE
	    ;CALL routine_tempo
	    ;INCF mode
	    GOTO BOUCLE_MAIN
	TESTE_MODE3
	    CALL routine_tempo
	    MOVLW d'3'
	    CPFSEQ mode
	    GOTO TESTE_MODE0
	    CALL MODE_CLIGNOTEMENT_LEDS
	    GOTO BOUCLE_MAIN
    GOTO BOUCLE_MAIN

    END