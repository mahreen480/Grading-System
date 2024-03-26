include emu8086.inc
org 100h
.data 
    numberOfStudents dw 0                                                             
	marksArray db 50 DUP (?)           
	idArray db 50 DUP (?)
	gradeArray db 50 DUP (?)
    marks db 0
	MSG1 db 'Enter the number of students(DOES NOT EXCEED 50): ','$'                                 
	MSG2 db 'Enter the IDs of students: ','$'                     
	MSG3 db 0dh,0ah, 0dh,0ah,'Enter the marks of students: ','$'
	MSG4 db 0dh,0ah, 0dh,0ah,'ID: ',09h,'MARKS:',09h,'GRADE:','$'                                
	HR db '******************* Class Result ***********************','$'    

.code
main proc
    mov ax, @data
    mov ds,ax
    
    start:
    mov ax,3      
    int 10h        
    mov dx,offset MSG1
    mov ah,9
    int 21h 
    call scan_num
    mov numberOfStudents,cx
    cmp numberOfStudents,50
        jg errorBlock
    cmp numberOfStudents,0
        jl errorblock
    jmp mainStart
        
    errorBlock:
        mov ax,3
        int 10h
        print "Invalid Number of Students! Enter Valid Number of Students "
        call scan_num 
        mov cx,0
        jmp start 
    mainStart:
    mov ax, 3
    int 10h
    mov si, 0
    LOOP1:  
             
            mov dx, offset MSG2	
            mov ah,9
            int 21h
            call scan_num 
        	mov idArray[si],cl
            mov dx, offset MSG3
            mov ah,9
            int 21h
            call scan_num
            mov marksArray[si],CL
        	inc si  
        	print 0ah        
        	print 0dh         
        	cmp si,numberOfStudents 
        	jne LOOP1
    mov ax, 3
    int 10h
    mov dx, offset HR
    mov ah,9
    int 21h
    mov dx, offset MSG4
    mov ah,9
    int 21h 
    print 0ah 
    print 0dh  	
    mov si, 0
    LOOP3:  	
            mov ax,0
        	mov al,idArray[si]     
        	call print_num_uns    
        	print 09h            
        	mov al,marksArray[si]
        	call print_num_uns 
        	print 09h
            mov marks,al 
            
            cmp marks,100
            jg error
            cmp marks,90
            jge first 
            cmp marks,85
            jge second 
            cmp marks,80
            jge third
            cmp marks,75
            jge fourth  
            cmp marks,70
            jge fifth  
            cmp marks,65
            jge sixth  
            cmp marks,60
            jge seventh  
            cmp marks,55
            jge eighth  
            cmp marks,50
            jge ninth 
            cmp marks,40
            jge tenth
            cmp marks,40
            jl fail
            cmp marks,0
            jl error
           
            first:
                print 'A+'
                jmp thread  
            second:
                print 'A'
                jmp thread
            third:
                print 'A-'
                jmp thread    
            fourth:
                print 'B+'
                jmp thread
            fifth:
                print 'B'
                jmp thread
            sixth:
                print 'C+'
                jmp thread
            seventh:
                print 'C'
                jmp thread 
            eighth:
                print 'D+'
                jmp thread
            ninth:
                print 'D'
                jmp thread 
            tenth:
                print 'E'
                jmp thread
            fail:
                print 'F'
                jmp thread
            error:
                print 'Invalid Marks' 
                jmp thread  
                
            thread:
        	print 0ah             
        	print 0dh            
        	inc si 
        	cmp si,numberOfStudents 
        	jne LOOP3 
        	call scan_num
        	mov cx,0
        	option:
        	mov ax,3
        	int 10h
        	print "Try Another: "
        	print 0ah
        	print 0dh
        	print "1) Yes" 
        	print 0ah
        	print 0dh
        	print "2) No" 
        	print 0ah
        	print 0dh
        	print "Select Option: "
        	call scan_num
        	cmp cl,1
        	    je start
        	cmp cl,2
        	    jne errorOption
        	jmp endOfProgram
        	errorOption: 
        	    mov ax,3
        	    int 10h
        	    print "Invalid Option! Select Valid Option "
        	    call scan_num
        	    mov cx,0
        	    jmp option 
        	
        	endOfProgram:
        	    mov ax,3
        	    int 10h
        	    print "Thanks for using me ;)"
        	    
        	
DEFINE_SCAN_NUM            
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
end mainp
main end