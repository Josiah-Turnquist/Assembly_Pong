; (_DrawScore.asm)

include Pong.inc

SCORE_OFFSET = 3d

.code 
DrawScore proc,
     textcolor: dword,
     color: dword,
	boardTopOffset: dword,
	boardLeftEdgeOffset: dword,
     boardWidth: dword,
	boardHeight: dword,
	borderWidth: dword,
	space: ptr byte,
     p1score: dword,
     p2score: dword,
     p1string: ptr dword,
     p2string: ptr dword
	
     ; textcolor - color of text on the gui
     ; color - GUI_COLOR passed in through main; aka the color of the fram and background of the text
	; boardTopOffset - distance from the top edge of the console to the top edge of the game board
     ; boardLeftEdgeOffset - distance from the left edge of the console to the left edge of the game board
	; boardWidth - width of the board
	; boardHeight - the height of the board
	; borderWidth - the width of the boarder lines
     ; space - the offset of a fill character
     ; p1score - player 1's score passed through main
     ; p2score - player 2's score passed through main
     ; p1string - player 1's gui string passed through main
     ; p2string - player 2's gui string passed through main
     
     pushad
     ; ---------------------- set color
     mov eax, color
     add eax, textcolor
	call SetTextColor
     
     ; error below
     mov dl, byte PTR boardLeftEdgeOffset
     mov dh, byte PTR boardTopOffset
     add dh, byte PTR boardHeight
     add dh, 1d
     call Gotoxy

                                                  ; score 1
     mov ecx, SCORE_OFFSET
sc1:
     mov edx, space
     call WriteString
     loop sc1
     
     pushad
     mov edx, p1string
     call WriteString
     mov eax, p1score
     call WriteDec
     popad
                                                       ; score 1
     mov ecx, boardWidth
     sub ecx, 17d * 2
     sub ecx, SCORE_OFFSET
     sub ecx, 3                                   ; per each dec printed
sc2:
     mov edx, space
     call WriteString
     loop sc2
     
     mov edx, p2string
     call WriteString
     mov eax, p2score
     call WriteDec

     mov ecx, SCORE_OFFSET
sc3:
     mov edx, space
     call WriteString
     loop sc3

     popad
     ret
DrawScore endp
end
