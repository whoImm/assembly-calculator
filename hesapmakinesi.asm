.model small
.stack 1000h

.data
menu        db 13,10,'=================================',13,10
            db '        16-BIT HESAP MAKINESI',13,10
            db '=================================',13,10
            db 'gelistirici: palyac0',13,10
            db 'discord: palyac0',13,10  
            db 'github: whoImm',13,10
            db '=================================',13,10
            db 'operatorler:',13,10
            db '  a -> toplama islemi       (+)',13,10
            db '  b -> cikarma islemi       (-)',13,10
            db '  c -> carpma islemi        (*)',13,10
            db '  d -> bolme islemi         (/)',13,10
            db '=================================',13,10,10
            db '1. sayiyi giriniz: $'

num1_msg    db 13,10,'1. sayiyi gir: $'
num2_msg    db 13,10,'2. sayiyi gir: $'
operator_msg db 13,10,'operator sec (a/b/c/d): $'
result_msg  db 13,10,'>> islem sonucu: $'
error_msg   db 13,10,'>> hata gecersiz islem.$'
div_zero_msg db 13,10,'>> hata sifira bolme hatasi.$'
overflow_msg db 13,10,'>> hata sayi asimi!$'
newline     db 13,10,'$'
continue_msg db 13,10,'>> devam etmek icin herhangi bir tusa bas...$'

; değişkenler
num1        dw 0    ; birinci sayı
num2        dw 0    ; ikinci sayı  
result      dw 0    ; işlem sonucu
temp        dw 0    ; geçici değişken
operator    db ?    ; operatör (a/b/c/d)
neg_flag    db 0    ; negatif sayı bayrağı

.code
main proc
    ; data segmenti ayarla
    mov ax, @data
    mov ds, ax
    ;mov es, ax  ; debug için extra segment - sonra kapattım
    ;jmp test_et ; debug atlaması - silinecek
    
calculator_loop:
    ; değişkenleri sıfırla
    mov num1, 0
    mov num2, 0
    mov result, 0
    mov neg_flag, 0
    ;mov cx, 0ffffh ; debug değeri - comment out

    ; 1. sayıyı al
    mov ah, 09h
    mov dx, offset menu
    int 21h
    call get_number      ; sayı giriş fonksiyonunu çağır
    ;push ax ; debug - stack kontrol
    mov num1, ax         ; girilen sayıyı num1'e kaydet
    ;pop bx  ; debug - stack temizle
    
    ; operatörü al
    mov ah, 09h
    mov dx, offset operator_msg
    int 21h
    
    mov ah, 01h          ; tek karakter giriş fonksiyonu
    int 21h
    ;cmp al, 0 ; debug - null check
    ;je hata_ver
    mov operator, al     ; operatörü kaydet
    ;mov [operator+1], 0 ; debug - buffer clear

    ; 2. sayıyı al
    mov ah, 09h
    mov dx, offset num2_msg
    int 21h
    call get_number      ; sayı giriş fonksiyonunu çağır
    ;test ax, ax ; debug - zero check
    ;jz sıfır_kontrol
    mov num2, ax         ; girilen sayıyı num2'ye kaydet
    ;mov temp, ax ; debug - yedekle
    
    ; işlemi gerçekleştir
    cmp operator, 'a'
    je do_addition
    cmp operator, 'b'
    je do_subtraction
    cmp operator, 'c'
    je do_multiplication
    cmp operator, 'd'
    je do_division
    ;jmp default_case ; debug - fallthrough

    ; geçersiz operatör
    mov ah, 09h
    mov dx, offset error_msg
    int 21h
    jmp continue

; toplama
do_addition:
    mov ax, num1         ; birinci sayıyı ax yükle
    ;add ax, 0 ; debug - nop işlemi
    add ax, num2         ; ikinci sayıyı ekle
    jo overflow_error    ; signed taşma kontrolü
    mov result, ax       ; sonucu kaydet
    jmp show_result

; çıkarma
do_subtraction:
    mov ax, num1         ; birinci sayıyı ax yükle
    ;sub ax, 0 ; debug - nop
    sub ax, num2         ; ikinci sayıyı çıkar
    jo overflow_error    ; signed taşma kontrolü
    mov result, ax       ; sonucu kaydet
    jmp show_result

; çarpma
do_multiplication:
    mov ax, num1         ; birinci sayıyı ax yükle
    mov bx, num2         ; ikinci sayıyı bx yükle
    imul bx              ; signed çarpma
    jo overflow_error    ; signed taşma kontrolü
    mov result, ax       ; sonucu kaydet
    jmp show_result

; bölme
do_division:
    mov ax, num2         ; böleni kontrol et
    cmp ax, 0            ; sıfıra bölme kontrolü
    je div_zero_error    ; sıfırsa hata
    ;jz div_zero_error2 ; debug - zero flag
    mov ax, num1         ; bölünen sayıyı ax yükle
    cwd                  ; dx:ax sign extend et
    idiv num2            ; signed bölme
    mov result, ax       ; bölümü kaydet
    ;mov temp, dx ; debug - kalanı sakla
    jmp show_result

; taşma hatası
overflow_error:
    ;push ax ; debug - register koruma
    mov ah, 09h
    mov dx, offset overflow_msg
    int 21h
    ;pop ax  ; debug - register geri yükle
    jmp continue

; sıfıra bölme hatası
div_zero_error:
    ;mov bx, offset div_zero_msg ; debug - offset test
    mov ah, 09h
    mov dx, offset div_zero_msg
    int 21h
    jmp continue

; sonucu göster
show_result:
    mov ah, 09h
    mov dx, offset result_msg
    int 21h
    ;call delay ; debug - bekleme
    
    ; sonucu ekrana yazdır
    mov ax, result
    call print_number
    ;jmp continue_clean ; debug - temiz devam

; devam sor
continue:
    ; devam mesajını göster
    mov ah, 09h
    mov dx, offset continue_msg
    int 21h
    ;mov cx, 3 ; debug - 3 saniye bekleme
    
    ; bir tuşa basmasını bekle
    mov ah, 01h
    int 21h
    ;cmp al, 1bh ; debug - esc kontrol
    ;je program_sonu
    
    ; yeni satıra geç
    mov ah, 09h
    mov dx, offset newline
    int 21h
    ;call clear_screen ; debug - ekran temizleme
    
    ; programı başa döngüle
    jmp calculator_loop
    
    ; debug etiketleri - asla çalışmaz
    ;hata_ver:
    ;   mov ah, 4ch
    ;   int 21h
    
    ;test_et:
    ;   mov ax, 1234h
    ;   jmp calculator_loop

    mov ah, 4ch
    int 21h
main endp

get_number proc
    push bx
    push cx
    push dx

    mov bx, 0        ; bx sıfırla (geçici depo)
    mov cx, 0        ; cx sıfırla (geçici)
    mov neg_flag, 0

    ; ilk karakteri oku
    mov ah, 01h
    int 21h
    
    ; eksi işareti kontrolü
    cmp al, '-'
    jne ilk_rakam_kontrol
    mov neg_flag, 1
    jmp devam_oku
    
ilk_rakam_kontrol:
    ; enter tuşu kontrolü
    cmp al, 13
    je input_done
    ; rakam kontrolü
    cmp al, '0'
    jb hatali_giris
    cmp al, '9'
    ja hatali_giris
    jmp rakam_islem
    
hatali_giris:
    ; geçersiz karakter - tekrar dene
    jmp devam_oku
    
devam_oku:
    ; sonraki karakteri oku
    mov ah, 01h
    int 21h
    jmp input_loop

input_loop:
    ; enter tuşu kontrolü (girişi bitir)
    cmp al, 13
    je input_done
    
    ; rakam kontrolü (0-9)
    cmp al, '0'
    jb devam_oku      ; 0 dan küçükse yeni karakter oku
    cmp al, '9'
    ja devam_oku      ; 9 dan büyükse yeni karakter oku
    
rakam_islem:    
    ; geçerli rakam
    sub al, '0'       ; asciiden sayıya çevir
    mov cl, al        ; cl rakamı kaydet
    mov ch, 0

    ; mevcut sayıyı 10 ile çarp ve yeni rakamı ekle
    mov ax, bx        ; mevcut sayıyı ax al
    mov dx, 10        ; çarpım için 10
    mul dx            ; ax * 10 -> dx:ax
    
    ; taşma kontrolü (32767'den büyük olmamalı)
    cmp dx, 0
    jne overflow_giris
    cmp ax, 32767
    ja overflow_giris
    
    mov bx, ax        ; sonucu bx geri kaydt
    add bx, cx        ; yeni rakamı ekle
    
    ; taşma kontrolü
    cmp bx, 32767
    ja overflow_giris
    
    ; bir sonraki karakteri oku
    mov ah, 01h
    int 21h
    jmp input_loop

overflow_giris:
    ; taşma varsa hata mesajı göster
    mov ah, 09h
    mov dx, offset overflow_msg
    int 21h
    mov bx, 0         ; sayıyı sıfırla
    mov neg_flag, 0
    jmp input_done
    
input_done:
    ; negatifse two complement al
    cmp neg_flag, 1
    jne pozitif_sonuc
    neg bx            ; sayıyı negatif yap

pozitif_sonuc:
    ; sonucu ax kaydet
    mov ax, bx
    
    pop dx
    pop cx
    pop bx
    ret
get_number endp

print_number proc
    push ax
    push bx
    push cx
    push dx
    ;push di ; debug - extra register

    mov ax, result   ; yazdırılacak sayı
    
    ; negatif kontrolü
    test ax, ax
    jns pozitif_yazdir
    ;js negatif_yazdir ; debug - signed flag
    
    ; negatif sayıyı yazdır
    push ax
    mov dl, '-'
    mov ah, 02h
    int 21h
    pop ax
    neg ax           ; pozitife çevir

pozitif_yazdir:
    mov bx, 10       ; bölme için 10
    mov cx, 0        ; basamak sayacı
    ;mov dx, 0       ; debug - clear dx
    
    ; sıfır kontrolü
    cmp ax, 0
    jne divide_loop
    ;jnz divide_loop2 ; debug - not zero

    ; sayı sıfırsa direkt yazdır
    mov dl, '0'
    mov ah, 02h
    int 21h
    jmp print_done
    ;jmp print_cleanup ; debug - temiz çıkış

    ; basamakları ayır
divide_loop:
    mov dx, 0        ; dx sıfırla (bölme için)
    div bx           ; ax / 10 -> ax: bölüm, dx: kalan
    ;xchg ax, dx     ; debug - swap
    push dx          ; basamağı stack kaydet
    inc cx           ; basamak sayacını artır
    ;add cx, 1       ; debug - alternatif artırma
    cmp ax, 0        ; bölüm sıfır mı
    jne divide_loop  ; değilse devam
    ;jz print_digits ; debug - zero flag
    
    ; basamakları yazdır
print_loop:
    pop dx           ; stack basamağı al
    add dl, '0'      ; sayıyı asciiye çevir
    mov ah, 02h      ; karakter yazdırma fonksiyonu
    int 21h          ; karakteri yazdır
    ;mov [temp], dx  ; debug - karakteri sakla
    loop print_loop  ; tüm basamaklar yazdırılana kadar devam
    ;jcxz print_done ; debug - counter zero check
    
print_done:
    ;pop di ; debug - extra register
    pop dx
    pop cx
    pop bx
    pop ax
    ret
    
    ; debug fonksiyonları - asla çalışmaz
    ;delay:
    ;   mov cx, 0ffffh
    ;delay_loop:
    ;   nop
    ;   loop delay_loop
    ;   ret
print_number endp

end main