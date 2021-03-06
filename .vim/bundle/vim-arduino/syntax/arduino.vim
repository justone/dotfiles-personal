" Vim syntax file
" Language:    Arduino
" Maintainer:  Johannes Hoff <johannes@johanneshoff.com>
" Last Change: 17 May 2015
" License:     VIM license (:help license, replace vim by arduino.vim)

" Syntax highlighting like in the Arduino IDE
" Automatically generated by the script available at
"    https://bitbucket.org/johannes/arduino-vim-syntax
" Using keywords from <arduino>/build/shared/lib/keywords.txt
" From version: ARDUINO 1.6.4 - 2015.05.06

" Thanks to Rik, Erik Nomitch, Adam Obeng, Graeme Cross and Niall Parker
" for helpful feedback!

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Read the C syntax to start with
if version < 600
  so <sfile>:p:h/cpp.vim
else
  runtime! syntax/cpp.vim
endif

syn keyword arduinoConstant  BIN CHANGE DEC DEFAULT EXTERNAL FALLING HALF_PI HEX
syn keyword arduinoConstant  HIGH INPUT INPUT_PULLUP INTERNAL INTERNAL1V1
syn keyword arduinoConstant  INTERNAL2V56 LOW LSBFIRST MSBFIRST OCT OUTPUT PI
syn keyword arduinoConstant  RISING TWO_PI

syn keyword arduinoFunc      analogRead analogReference analogWrite
syn keyword arduinoFunc      attachInterrupt bit bitClear bitRead bitSet
syn keyword arduinoFunc      bitWrite delay delayMicroseconds detachInterrupt
syn keyword arduinoFunc      digitalRead digitalWrite highByte interrupts
syn keyword arduinoFunc      lowByte micros millis noInterrupts noTone pinMode
syn keyword arduinoFunc      pulseIn shiftIn shiftOut tone yield

syn keyword arduinoMethod    available availableForWrite begin charAt compareTo
syn keyword arduinoMethod    concat end endsWith equals equalsIgnoreCase find
syn keyword arduinoMethod    findUntil flush getBytes indexOf lastIndexOf length
syn keyword arduinoMethod    loop parseFloat parseInt peek print println read
syn keyword arduinoMethod    readBytes readBytesUntil readString readStringUntil
syn keyword arduinoMethod    replace setCharAt setTimeout setup startsWith
syn keyword arduinoMethod    substring toCharArray toInt toLowerCase toUpperCase
syn keyword arduinoMethod    trim word

syn keyword arduinoModule    Keyboard Mouse Serial Serial1 Serial2 Serial3
syn keyword arduinoModule    SerialUSB

syn keyword arduinoStdFunc   abs accept acos asin atan atan2 ceil click constrain
syn keyword arduinoStdFunc   cos degrees exp floor isPressed log map max min
syn keyword arduinoStdFunc   move pow press radians random randomSeed release
syn keyword arduinoStdFunc   releaseAll round sin sq sqrt tan

syn keyword arduinoType      boolean byte null String word

hi def link arduinoType Type
hi def link arduinoConstant Constant
hi def link arduinoStdFunc Function
hi def link arduinoFunc Function
hi def link arduinoMethod Function
hi def link arduinoModule Identifier
