Object subclass: Mapper [
    | left right range note |
    <comment:
        'I represent a place to deposit and withdraw money'>
    Mapper class >> new [
        <category: 'instance creation'>
        | r |
        r := super new.
        r init.
        ^r
    ]
    init [
        <category: 'initialization'>
        left := 'left'.
        right := 'right'.
        range := 0.
    ]
    diff [
      ^(left - right)
    ]
    rtl_translate: x [
      ^(x + (self diff))
    ]
    within_right: x [
      ^(
        (x >= (right))
        and: [
          (x <= (right + range - 1))
        ]
      ).
    ]
]
Mapper extend [
        printOn: stream [
            <category: 'printing'>
            super printOn: stream.

            stream nextPutAll: ' left: '.
            left printOn: stream.

            stream nextPutAll: ', right: '.
            right printOn: stream.

            stream nextPutAll: ' :: diff: '.
            (self diff) printOn: stream.

            stream nextPutAll: ', range: '.
            range printOn: stream.

            (note isNil)
                  ifFalse: [
                      stream nextPutAll: ' note: '.
                      note printOn: stream.
                  ].
        ]
        left: a right: b [
          left := a.
          right := b.
        ]
        range: r [
          range := r.
        ]
        note: a [
          note := a.
        ]
    ]


'xxxxxxx' printNl.
a := Mapper new.
a printNl.
'xxxxxxx' printNl.

a := Mapper new left: 'sprouts' right: 'beans'.
a printNl.

b := 3952045923.
c := 3952045923 * 3.

(b ) printNl.
(c ) printNl.
(c > b ) printNl.
(c < b ) printNl.
'_------' printNl.

x := Array new: 4.
x at: 1 put: 10.
x at: 2 put: 20.
x printNl.

(('444444' asNumber) + 11111100) printNl.


('aaa      bb cc' substrings: ' ') printNl.

Object extend [
  foo [
    'darn right' printNl.
  ]
  append: a1 to: a2 [ | local |
    local := Array new: ((a1 size)+(a2 size)).
    1 to: (a1 size) do: [:x |
       (local at: x put: (a1 at: x)).
    ].
    1 to: (a2 size) do: [:x |
       (local at: (x + (a1 size)) put: (a2 at: x)).
    ].
    ^local.
  ]
  subject: x in_range: a to: b [
    ^(
      (x >= (a))
      and: [
        (x <= (a + b - 1))
      ]
    )
  ]
].

self foo.

#(#(123 456 7)
 #(123 456 7)
 #(123 456 7)
 #(123 456 7)) printNl.

seeds := #(79 14 55 13).

seed_to_soil := #(
  #(50 98 2)
  #(52 50 48)
).

soil_to_fertilizer := #(
  #(0 15 37)
  #(37 52 2)
  #(39 0 15)
).

fertilizer_to_water := #(
  #(49 53 8)
  #(0 11 42)
  #(42 0 7)
  #(57 7 4)
).

water_to_light := #(
  #(88 18 7)
  #(18 25 70)
).

light_to_temperature := #(
  #(45 77 23)
  #(81 45 19)
  #(68 64 13)
).

temperature_to_humidity := #(
  #(0 69 1)
  #(1 0 69)
).

humidity_to_location := #(
  #(60 56 37)
  #(56 93 4)
).


1 to: (seeds size) do: [:x |
   x print.
   ' ' print.
   (seeds at:x) printNl.
].

sorted_seeds := ((seeds asSortedCollection: [:a :b | a < b]) asArray) printNl.
sorted_ftw := ((fertilizer_to_water asSortedCollection: [:a :b |
       (a at: 1) < (b at: 1)
      ]) asArray) printNl.


'END' printNl.

z := ([ :x | 1 + x ]).



Object subclass: Mapset [
    | name mappers |
    <comment: 'I hold many mappers'>
    Mapset class >> new [
        <category: 'instance creation'>
        | r |
        r := super new.
        r init.
        ^r
    ]
    init [
        <category: 'initialization'>
        name := 'default'.
        mappers := #().
    ]
].
Mapset extend [
        printOn: stream [
            <category: 'printing'>
            super printOn: stream.

            stream nextPutAll: ' name: '.
            name printOn: stream.

            stream nextPutAll: ' map size: '.
            (mappers size) printOn: stream.

            1 to: (mappers size) do: [ :i |
'
...' printOn: stream.
              mappers printOn: stream.
            ]
        ]
        name: a [
          name := a.
        ]
        add: mapper [ |zzz|
          zzz := Array new: 1.
          zzz at: 1 put: mapper.
          mappers := Object append: mappers to: zzz.
        ]
        source_for: num [ | found local |
"         (name printNl).
"
"         ('rtl in, out:' printNl).
"
"         (num printNl).
"
          1 to: (mappers size) do: [:i |
            local := mappers at: i.
            (local within_right: num)
              ifTrue: [
"               (local printNl).
"
"               ((local rtl_translate: num) printNl).
"
                ^(local rtl_translate: num).
              ].
          ].
"         (num printNl).
"
          ^num
        ]
    ]

m := Mapper new.
l := light_to_temperature at: 1.
m left: (l at: 1) right: (l at: 2).
m printNl.

m range: (l at: 3).
m printNl.

xxx := Mapset new name: 'sprouts to grass'.
xxx printNl.
xxx add: m.
xxx printNl.

GGa := #(1 2 3).
GGb := #(5 6 7).
GGc printNl.

ggg := Object append: #(1 2 3) to: #(4 5 6).
ggg printNl.
'xxxxxxxxxxxxx' printNl.

seed_to_soil_mapset := Mapset new name: 'seed_to_soil'
1 to: (seed_to_soil size) do: [ :i |
  seed_to_soil_mapset add:
  (((Mapper new)
    left:  ((seed_to_soil at: i) at: 2)
    right: ((seed_to_soil at: i) at: 1)
  ) range: ((seed_to_soil at: i) at: 3)).
].

soil_to_fertilizer_mapset := Mapset new name: 'soil_to_fertilizer'
1 to: (soil_to_fertilizer size) do: [ :i |
  soil_to_fertilizer_mapset add:
  (((Mapper new)
    left:  ((soil_to_fertilizer at: i) at: 2)
    right: ((soil_to_fertilizer at: i) at: 1)
  ) range: ((soil_to_fertilizer at: i) at: 3)).
].

fertilizer_to_water_mapset := Mapset new name: 'fertilizer_to_water'
1 to: (fertilizer_to_water size) do: [ :i |
  fertilizer_to_water_mapset add:
  (((Mapper new)
    left:  ((fertilizer_to_water at: i) at: 2)
    right: ((fertilizer_to_water at: i) at: 1)
  ) range: ((fertilizer_to_water at: i) at: 3)).
].

water_to_light_mapset := Mapset new name: 'water_to_light'
1 to: (water_to_light size) do: [ :i |
  water_to_light_mapset add:
  (((Mapper new)
    left:  ((water_to_light at: i) at: 2)
    right: ((water_to_light at: i) at: 1)
  ) range: ((water_to_light at: i) at: 3)).
].

light_to_temperature_mapset := Mapset new name: 'light_to_temperature'
1 to: (light_to_temperature size) do: [ :i |
  light_to_temperature_mapset add:
  (((Mapper new)
    left:  ((light_to_temperature at: i) at: 2)
    right: ((light_to_temperature at: i) at: 1)
  ) range: ((light_to_temperature at: i) at: 3)).
].

temperature_to_humidity_mapset := Mapset new name: 'temperature_to_humidity'
1 to: (temperature_to_humidity size) do: [ :i |
  temperature_to_humidity_mapset add:
  (((Mapper new)
    left:  ((temperature_to_humidity at: i) at: 2)
    right: ((temperature_to_humidity at: i) at: 1)
  ) range: ((temperature_to_humidity at: i) at: 3)).
].

humidity_to_location_mapset := Mapset new name: 'humidity_to_location'
1 to: (humidity_to_location size) do: [ :i |
  humidity_to_location_mapset add:
  (((Mapper new)
    left:  ((humidity_to_location at: i) at: 2)
    right: ((humidity_to_location at: i) at: 1)
  ) range: ((humidity_to_location at: i) at: 3)).
].


" seed_to_soil               "
" soil_to_fertilizer         "
" fertilizer_to_water        "
" water_to_light             "
" light_to_temperature       "
" temperature_to_humidity    "
" humidity_to_location       "


1 to: 1000 do: [ :location |
  "example test 46"
  maybe_seed := (seed_to_soil_mapset source_for:
    (soil_to_fertilizer_mapset source_for:
      (fertilizer_to_water_mapset source_for:
        (water_to_light_mapset source_for:
          (light_to_temperature_mapset source_for:
            (temperature_to_humidity_mapset source_for:
              (humidity_to_location_mapset source_for: location)
            )
          )
        )
      )
    )
  ).

  found := false.
  1 to: ((seeds size)/2) do: [ :i |
    found ifFalse: [
      found := found or: [(
        Object subject: maybe_seed in_range: ( seeds at: ((i * 2)-1)) to: ( seeds at: (i * 2) )
      )].
    ].
    found ifTrue: [
      'FOUND location with source' printNl.
      'location' printNl.
      location printNl.
      'seed' printNl.
      maybe_seed printNl.
      ^'done'.
    ].
"    'xxxxxxxx' printNl.
"
  ].
]
