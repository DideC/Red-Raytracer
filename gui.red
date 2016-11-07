Red []

posx: 		"0.0"
posy: 		"0.0"
posz: 		"0.0"
tarx: 		"0.0"
tary: 		"0.0"
tarz: 		"-1.0"
samples: 	"10"
depth: 		"40"
fov: 		"90"
scene-block: "redsphere sphere radius 0.5 position 0.0 0.0 -1.0 lambert 1.0 0.2 0.2 0.0"

font-Consolas: make font! [
	name: "Consolas"
	size: 10
	color: black
	style: []
	anti-alias?: yes
]

font-Consolas-light: make font! [
	name: "Consolas"
	size: 10
	color: 200.200.200
	style: []
	anti-alias?: yes
]

font-Consolas-gray: make font! [
	name: "Consolas"
	size: 10
	color: 180.180.180
	style: []
	anti-alias?: yes
]

canvas: make face! [
	type: 'base offset: 0x0 size: 650x610 color: pewter
	draw: [

		pen 95.95.95			;--Big box
		fill-pen 105.105.105
		box 0x0 114x199 10

		pen 60.60.60 			;--Camera Position Shadow
		fill-pen 60.60.60
		box 3x3 113x27 8
		pen 100.100.100 		;--Camera Position Box
		fill-pen linear 0x100 75 170 90 white gray black
		box 2x2 112x26 8

		pen 60.60.60 			;--X box shadow
		fill-pen 60.60.60
		box 11x29 106x49 4
		pen 100.100.100 		;--x box
		fill-pen 120.120.120
		box 10x28 105x48 4

		pen 60.60.60 			;--Y box shadow
		fill-pen 60.60.60
		box 11x51 106x71 4
		pen 100.100.100
		fill-pen 120.120.120
		box 10x50 105x70 4

		pen 60.60.60 			;--Z box shadow
		fill-pen 60.60.60
		box 11x73 106x93 4
		pen 100.100.100
		fill-pen 120.120.120
		box 10x72 105x92 4

		pen 60.60.60 			;--Camera Target Shadow
		fill-pen 60.60.60
		box 3x99 113x123 8
		pen 100.100.100 		;--Camera Target Box
		fill-pen linear 0x100 75 170 90 white gray black
		box 2x98 112x122 8


		fill-pen off
		pen 60.60.60 			;--X box shadow
		fill-pen 60.60.60
		box 11x125 106x145 4
		pen 100.100.100
		fill-pen 120.120.120
		box 10x124 105x144 4

		pen 60.60.60 			;--Y box shadow
		fill-pen 60.60.60
		box 11x147 106x167 4
		pen 100.100.100
		fill-pen 120.120.120
		box 10x146 105x166 4

		pen 60.60.60 			;--Z box shadow
		fill-pen 60.60.60
		box 11x169 106x189 4
		pen 100.100.100
		fill-pen 120.120.120
		box 10x168 105x188 4




		pen 95.95.95			;--Big box Settings
		fill-pen 105.105.105
		box 0x210 114x310 10

		pen 60.60.60 			;--Settings Shadow
		fill-pen 60.60.60
		box 3x213 113x237 8
		pen 100.100.100 		;--Settings Box
		fill-pen linear 0x100 200 270 90 white gray black
		box 2x212 112x236 8

		pen 60.60.60 			;--Samples box shadow
		fill-pen 60.60.60
		box 6x239 110x259 4
		pen 100.100.100
		fill-pen 120.120.120
		box 5x238 109x258 4

		pen 60.60.60
		fill-pen 60.60.60
		box 6x261 110x281 4
		pen 100.100.100
		fill-pen 120.120.120
		box 5x260 109x280 4

		pen 60.60.60
		fill-pen 60.60.60
		box 6x283 110x303 4
		pen 100.100.100
		fill-pen 120.120.120
		box 5x282 109x302 4


		fill-pen 200.200.200
		box 134x270 642x378 4


		fill-pen off
		pen black
		font font-Consolas-gray
		text 6x7 "Camera Position"
		text 13x103 "Camera Target"
		text 31x217 "Settings"
		font font-Consolas
		text 5x6 "Camera Position"
		text 12x102 "Camera Target"
		text 30x216 "Settings"
		text 31x31 "X:"
		text 31x53 "Y:"
		text 31x75 "Z:"

		text 31x127 "X:"
		text 31x149 "Y:"
		text 31x171 "Z:"

		text 11x241 "Samples:"
		text 11x263 "Depth:"
		text 11x285 "FOV:"

		font font-Consolas-light
		text 30x30 "X:"
		text 30x52 "Y:"
		text 30x74 "Z:"

		text 30x126 "X:"
		text 30x148 "Y:"
		text 30x170 "Z:"

		text 10x240 "Samples:"
		text 10x262 "Depth:"
		text 10x284 "FOV:"
	]
]


win: make face! [
	type: 'window text: "Ray Tracer" size: 676x450 color: pewter
	menu: [
		"File" [
			"Save Image..."		save-as
			---
			"Exit"				exit
		]
	]
	actors: object [
		on-menu: func [face [object!] event [event!]][
			switch event/picked [
				save-as [
					save-as-png
				]
				exit [
					unview/all
				]
			]
		]
	]
]

; Predefine fields object
field-large!: make face! [
	type: 'field text: "0.0" size: 50x15
	color: 120.120.120
	font: font-Consolas
	para: make para! [align: 'left]
	flags: [no-border]
]

field-small!: make field-large! [
	text: "0"
	size: 35x15
]

win/pane: reduce [

	make face! [										;-- clip view for canvas
		type: 'panel offset: 12x28 size: 650x610
		pane: reduce [canvas]
	]

	Display: make face! [										;--image area
		type: 'base offset: 150x28 size: 500x250
		image: make image! 500x250
	]

	Render-Button: make face! [
		type: 'button text: "Render" extra: 0%  offset: 12x350 size: 115x40 font: font-Consolas color: 50.50.50
		para: make para! [align: 'center]
		actors: object [
			on-click: func [face [object!] event [event!]][
				face/text: "(Rendering...)"
				face/enable?: false
				update-progress
;				parse-scene scene-block
;				Setup-Camera display/image samples depth fov posx posy posz tarx tary tarz
;				face/text: "Render"
				face/enable?: true
			]
		]
	]

	make face! [
		type: 'area text: scene-block offset: 150x302 size: 500x100 color: 200.200.200
		font: font-Consolas
		flags: [no-border]
		actors: object [
			on-change: func [face [object!] event [event!]][
				scene-block: face/text
			]
		]
	]

	make field-large! [
		text: posx offset: 60x58
		actors: object [
			on-change: func [face [object!] event [event!]][
				posx: face/text
			]
		]
	]

	make field-large! [
		text: posy offset: 60x80
		actors: object [
			on-change: func [face [object!] event [event!]][
				posy: face/text
			]
		]
	]

	make field-large! [
		text: posz offset: 60x102
		actors: object [
			on-change: func [face [object!] event [event!]][
				posz: face/text
			]
		]
	]

	make field-large! [
		text: tarx offset: 60x154
		actors: object [
			on-change: func [face [object!] event [event!]][
				tarx: face/text
			]
		]
	]

	make field-large! [
		text: tary offset: 60x176
		actors: object [
			on-change: func [face [object!] event [event!]][
				tary: face/text
			]
		]
	]

	make field-large! [
		text: tarz  offset: 60x198
		actors: object [
			on-change: func [face [object!] event [event!]][
				tarz: face/text
			]
		]
	]

	make field-small! [
		text: samples offset: 82x268
		actors: object [
			on-change: func [face [object!] event [event!]][
				samples: face/text
			]
		]
	]

	make field-small! [
		text: depth offset: 82x290
		actors: object [
			on-change: func [face [object!] event [event!]][
				depth: face/text
			]
		]
	]

	make field-small! [
		text: fov offset: 82x312
		actors: object [
			on-change: func [face [object!] event [event!]][
				fov: face/text
			]
		]
	]


]

update-progress: has [v s] [
	v: 1.0 / any [all [attempt [s: load samples] integer? s s] 1]
	Render-Button/extra: Render-Button/extra + v
	Render-Button/text: form render-Button/extra
]

;view/flags win [resize]
view win

quit