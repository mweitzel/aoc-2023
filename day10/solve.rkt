#!/usr/bin/racket
#lang racket

(define (read_maze file)
  (foldr
    (lambda ( next carry )
      (append (list next) carry))
    '()
    (file->lines file)))

; helpful to debug
; in retrospect, silly to use fold should have donw more take/drop
(define (subset ll x y w h)
  (car (foldl
    (lambda ( line carry )
      (let* ([sublist (car carry)]
            [meta (car (cdr carry))]
            [xx (car meta)]
            [subline (apply string (take (drop (string->list (string-join (list line) "")) x) w))]
            [yy (car (cdr meta))]
            [next_meta (list xx (+ yy 1))]
            )
        (cond
            [(and (>= yy y) (< yy (+ y h)))
              (list
                (append sublist (list subline))
                next_meta) ]
            [else
              (list
                sublist
                next_meta)]))
      )
    (list '() (list 0 0))
    ll)))

(define (display_maze maze)
  (displayln "~~~ maze ~~~")
  (for ([i maze])
      (displayln i))
  (displayln "~~~ maze ~~~"))

(let ([maze (read_maze "input")])
  (display_maze (subset maze 0 0 5 5))
)

; gotta find that "S"
(define (find_nested ll needle)
  (car (foldl
    (lambda ( line carry )
      (let* ([found (car carry)]
            [y (car (cdr carry))]
            )
        (cond
            [(> (length found) 0) carry]
            [(index-of (string->list line) needle)
              (let ([found_x (index-of (string->list line) needle)])
                (list (list found_x y) y))]
            [else
                (list '() (+ y 1))])))
    (list `() 0)
    ll)))


(define (maze_at maze x y)
  (car (take ( drop
      (string->list (car (take (drop maze y) 1)))
    x ) 1
  )))



(let ([maze (read_maze "example")])
  print ( find_nested maze "S")
  (displayln ":::::::::::")
  (let* (
    [loc (find_nested maze #\S)]
    [l (first loc)]
    [r (last loc)]
    )
  (displayln ":::::::::::")
  (print (maze_at maze l r))
  (displayln "??????????:")
  )

)

; docs were a bit hazy on iterators, so I just went and made an iterator
(define (gen done i fn)
  (cond
    [done i]
    [else
      (let* (
        [fn_out (fn i)]
        [did_end (first fn_out)]
        [next_i (second fn_out)])
        (cond
          [did_end i]
          [else (gen did_end next_i fn)])
      )
    ]
    ))

(gen #f 0
  (lambda (x)
    (let ([done (>= x 5)] ; "done" returns "i", and "next_i" will be ignored
           [next_i (+ x 1)])
          (list done next_i)))
)

(define (in_bounds? maze position)
  (and
    (>= (first position) 0)
    (>= (second position) 0)
    (< (first position) (length maze))
    (< (second position) (length maze))) ; gross, but safe because square
)


(define (matches? maze position char)
    (and
      (in_bounds? maze position)
      (equal?
        (maze_at maze (first position) (second position))
        char)))

(let ([maze (read_maze "input")])
  (display_maze maze)
  (displayln (find_nested maze #\S))
  (let ([initial (find_nested maze #\S)])
    (gen #f (list initial initial 1)
      (lambda (carry)
        (let* ([position      (first carry)]
              [last_position  (second carry)]
              [steps          (third carry)]
              [x              (first position)]
              [y              (second position)]
              [can_left       (or  (matches? maze position #\S) (matches? maze position #\7) (matches? maze position #\J) (matches? maze position #\-))]
              [can_right      (or  (matches? maze position #\S) (matches? maze position #\L) (matches? maze position #\F) (matches? maze position #\-))]
              [can_up         (or  (matches? maze position #\S) (matches? maze position #\L) (matches? maze position #\J) (matches? maze position #\|))]
              [can_down       (or  (matches? maze position #\S) (matches? maze position #\7) (matches? maze position #\F) (matches? maze position #\|))]
              [left  (list (- x 1) y)]
              [right (list (+ x 1) y)]
              [up    (list x (- y 1))]
              [down  (list x (+ y 1))]
              [zzz "zzzz"])

          (displayln " previous, present ")
          (print last_position)
          (print position)
          (displayln (maze_at maze (first position) (second position)))
          (cond
            [(or
                (and can_left
                     (matches? maze left #\S)
                     (not (equal? last_position left)))
                (and can_right
                     (matches? maze right #\S)
                     (not (equal? last_position right)))
                (and can_up
                     (matches? maze up #\S)
                     (not (equal? last_position up)))
                (and can_down
                     (matches? maze down #\S)
                     (not (equal? last_position down))))
              (list #t (list position position (+ steps 1)))
            ]
            [(and
                can_left
                (not (equal? last_position left))
                (or (matches? maze left #\-)
                    (matches? maze left #\F)
                    (matches? maze left #\L)))
              (list #f (list left position (+ steps 1)))
            ]
            [(and
                can_right
                (not (equal? last_position right))
                (or (matches? maze right #\-)
                    (matches? maze right #\J)
                    (matches? maze right #\7)))
              (list #f (list right position (+ steps 1)))
            ]
            [(and
                can_up
                (not (equal? last_position up))
                (or (matches? maze up #\|)
                    (matches? maze up #\F)
                    (matches? maze up #\7)))
              (list #f (list up position (+ steps 1)))
            ]
            [(and
                can_down
                (not (equal? last_position down))
                (or (matches? maze down #\|)
                    (matches? maze down #\J)
                    (matches? maze down #\L)))
              (list #f (list down position (+ steps 1)))
            ]
            [else (1)] ; panic? or invalid map
          )
        )
      ))
  )
)

(displayln "^ full length, furthest point is round_trip / 2")
