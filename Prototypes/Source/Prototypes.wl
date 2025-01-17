BeginPackage["Prototypes`", {"PacletManager`", "JLink`"}];

Get[ FileNameJoin[{DirectoryName[$InputFileName], "Usage.wl"}] ];

Begin["`Private`"];

applicationDataDirectory = FileNameJoin[{$UserBaseDirectory, "ApplicationData", "Prototypes"}];

If[ FileType[applicationDataDirectory] === None, CreateDirectory[applicationDataDirectory] ];

timings = <||>;
AppendTo[ timings, "Start" ->N@SessionTime[] ];

Module[ {files},

  If[ Not @ StringQ @ FrontEnd`Private`$KernelName || FrontEnd`Private`$KernelName === "Local" ,

    (* load in any session *)
    files = {"Build.wl", "Dataset.wl", "Files.wl", "Cloud.wl",
    "Image.wl", "Language.wl", "Paclet.wl", "Formats.wl", "Import.wl",
    "Resources.wl", "Search.wl", "String.wl", "System.wl", "Color.wl", "Styles.wl",
    "Entities.wl", "WolframAlpha.wl", "Translation.wl","GeoGraphics.wl", "Words.wl", "Packages.wl", "Random.wl",
    "Cryptography.wl", "External.wl", "Disable.wl", "Service/What3Words.wl", "Service/OpenSky.wl", "Service/Satellite.wl", "Service/IPStack.wl",
    "Primes/Primes.wl", "Java/Runtime.wl", "Java/Import.wl", "Compiler/Build.wl"};
    Map[
      Function[ {file},
        AppendTo[ timings, file<>"-Before" -> N@SessionTime[] ];
        Get[ FileNameJoin[{DirectoryName[$InputFileName], file}] ];
        AppendTo[ timings, file<>"-After" -> N@SessionTime[] ];
        ], files ];


    (* only load in a notebook session *)
    If[ Head[$FrontEnd] === FrontEndObject,
      files = {"Dock.wl","Notebook.wl"};
      Map[
        Function[ {file},
          AppendTo[ timings, file<>"-Before" -> N@SessionTime[] ];
          Get[ FileNameJoin[{DirectoryName[$InputFileName], file}] ];
          AppendTo[ timings, file<>"-After" -> N@SessionTime[] ];
          ], files
      ];
    ];
  ];
];

(*
If[
  $VersionNumber > 11.3,
  (* functions which have become System functions *)
  Prototypes`RandomGeoPosition=System`RandomGeoPosition;
  Prototypes`Antonyms=System`Antonyms;
  Prototypes`Synonyms=System`Synonyms;
]
*)

AppendTo[ timings, "End" ->N@SessionTime[] ];

End[];

EndPackage[];
