# -*- coding: utf-8 -*-

# http://www.burrellesluce.com/top100/2008_Top_100List.pdf
NEWSPAPER_CIRCS = {
  "USA Today"                            => [  1, 2284219,           0],
  "The Wall Street Journal"              => [  2, 2069463,           0 ,      "New York",             "NY",   ],
  "The New York Times"                   => [  3, 1077256,     1476400 ,      "New York",             "NY",   ],
  "Los Angeles Times"                    => [  4,  773884,     1101981],
  "The Daily News"                       => [  5,  703137,      704157 ,      "New York",             "NY",   ],
  "New York Post"                        => [  6,  702488,      401315 ,      "New York",             "NY",   ],
  "The Washington Post"                  => [  7,  673180,      890163],
  "Chicago Tribune"                      => [  8,  541663,      898703],
  "Houston Chronicle"                    => [  9,  494131,      632797],
  "Arizona Republic"                     => [ 10,  413332,      515523 ,      "Phoenix",              "AZ",   ],
  "Newsday"                              => [ 11,  379613,      441728 ,      "Melville",             "NY",   ],
  "San Francisco Chronicle"              => [ 12,  370345,      424603],
  "Dallas Morning News"                  => [ 13,  368313,      520215],
  "The Boston Globe"                     => [ 14,  350605,      525959],
  "The Star-Ledger"                      => [ 15,  345130,      500382 ,      "Newark",               "NJ",   ],
  "Philadelphia Inquirer"                => [ 16,  334150,      630665],
  "The Plain Dealer"                     => [ 17,  330280,      428090 ,      "Cleveland",            "OH",   ], # Daily: 335,656 Sunday 442,484
  "Atlanta Journal-Constitution"         => [ 18,  326907,      497149],
  "Star-Tribune"                         => [ 19,  322362,      534750 ,      "Minneapolis",          "MN",   ],
  "St. Petersburg Times"                 => [ 20,  316007,      432779],
  "Chicago Sun-Times"                    => [ 21,  312274,      247469],
  "Detroit Free Press"                   => [ 22,  308944,      606374],
  "The Oregonian of Portland"            => [ 23,  304399,      361988 ,      "Portland",             "OR",   ],
  "The San Diego Union Tribune"          => [ 24,  288669,      355537],
  "The Sacramento Bee"                   => [ 25,  268755,      307480],
  "The Indianapolis Star"                => [ 26,  255303,      324349],
  "St. Louis Post-Dispatch"              => [ 27,  255057,      414564],
  "Kansas City Star"                     => [ 28,  252785,      345332],
  "The Orange County Register"           => [ 29,  250724,      311982],
  "Miami Herald"                         => [ 30,  240223,      311245],
  "San Jose Mercury News"                => [ 31,  234772,      251851],
  "The Sun"                              => [ 32,  232360,      372970 ,      "Baltimore",            "MD",   ],
  "The Orlando Sentinel"                 => [ 33,  227593,      332030],
  "San Antonio Express-News"             => [ 34,  225447,      315959],
  "The Rocky Mountain News"              => [ 35,  225226,           0],
  "The Denver Post"                      => [ 36,  225193,           0],
  "The Seattle Times"                    => [ 37,  220863,           0],
  "Tampa Tribune"                        => [ 38,  220522,           0],
  "South Florida Sun-Sentinel"           => [ 39,  218286,      303399 ,      "Ft. Lauderdale",       "FL",   ],
  "Milwaukee Journal Sentinel"           => [ 40,  217755,      384539],
  "The Courier-Journal"                  => [ 41,  215328,      258778 ,      "Louisville",           "KY",   ],
  "Pittsburgh Post-Gazette"              => [ 42,  214374,      331053],
  "The Cincinnati Enquirer"              => [ 43,  212369,      279825],
  "The Charlotte Observer"               => [ 44,  210616,      264170],
  "Fort Worth Star-Telegram"             => [ 45,  207045,      289974],
  "The Oklahoman"                        => [ 46,  201771,      262150 ,      "Oklahoma City",        "OK",   ],
  "The Columbus Dispatch"                => [ 47,  199524,      334422],
  "St. Paul Pioneer-Press"               => [ 48,  191768,      252055],
  "The Detroit News"                     => [ 49,  188171,           0],
  "Contra Costa Times"                   => [ 50,  183086,      194203],
  "Boston Herald"                        => [ 51,  182350,      105629],
  "Arkansas Democrat-Gazette"            => [ 52,  182212,      274494 ,      "Little Rock",          "AR",   ],
  "New Orleans Times-Picayune"           => [ 53,  179834,      199970],
  "Omaha World-Herald"                   => [ 54,  178545,      219795],
  "The Buffalo News"                     => [ 55,  178365,      260445],
  "The News & Observer"                  => [ 56,  176083,      211245 ,      "Raleigh",              "NC",   ],
  "Richmond Times-Dispatch"              => [ 57,  175265,      205895],
  "The Virginian Pilot"                  => [ 58,  175005,      200012],
  "Las Vegas Review-Journal"             => [ 59,  174341,      199602],
  "Austin American-Statesman"            => [ 60,  170309,      206505],
  "The Hartford Courant"                 => [ 61,  168158,      237933],
  "The Palm Beach Post"                  => [ 62,  164474,      195608],
  "The Press-Enterprise"                 => [ 63,  164189,      172730 ,      "Riverside",            "CA",   ],
  "The Record"                           => [ 64,  163329,      195525 ,      "Hackensack",           "NJ",   ],
  "Investor’s Business Daily"            => [ 65,  161421,           0 ,      "Los Angeles",          "CA",   ],
  "The Tennessean"                       => [ 66,  161131,      219044 ,      "Nashville",            "TN",   ],
  "Tribune-Review"                       => [ 67,  150911,      192423 ,      "Greensburg",           "PA",   ],
  "The Fresno Bee"                       => [ 68,  150334,      171039],
  "The Commercial Appeal"                => [ 69,  146961,      188040],
  "Democrat & Chronicle"                 => [ 70,  145913,      199533 ,      "Rochester",            "NY",   ],
  "The Florida Times-Union"              => [ 71,  144391,      201352],
  "Daily Herald"                         => [ 72,  143152,      141091 ,      "Arlington Heights",    "IL",   ],
  "Asbury Park Press"                    => [ 73,  140882,      184095 ,      "Neptune",              "NJ",   ],
  "The Birmingham News"                  => [ 74,  140438,      170151],
  "The Honolulu Advertiser"              => [ 75,  140331,      150276],
  "The Providence Journal"               => [ 76,  139055,      192849],
  "The Des Moines Register"              => [ 77,  138519,      222122],
  "The Los Angeles Daily News"           => [ 78,  137344,      145164 ,      "Woodland Hills",       "CA",   ],
  "Seattle Post-Intelligencer"           => [ 79,  129563,           0],
  "The Grand Rapids Press"               => [ 80,  128930,      177026],
  "The Salt Lake Tribune"                => [ 81,  121699,      143296],
  "The Akron Beacon Journal"             => [ 82,  119929,      155436],
  "The Blade"                            => [ 83,  119901,      147141 ,      "Toledo",               "OH",   ],
  "The Knoxville News-Sentinel"          => [ 84,  117262,      147939],
  "Dayton Daily News"                    => [ 85,  116690,      157833],
  "Sarasota Herald-Tribune"              => [ 86,  114904,      125644],
  "La Opinion"                           => [ 87,  114892,      56027,        "Los Angeles",          "CA",   ],
  "Arizona Daily Star"                   => [ 88,  113373,      164033 ,      "Tucson",               "AZ"    ],
  "Tulsa World"                          => [ 89,  112968,      160052],
  "The News Tribune"                     => [ 90,  111778,      125955 ,      "Tacoma",               "WA"    ],
  "The News Journal"                     => [ 91,  110171,      125244 ,      "New Castle",           "DE",   ],
  "Post-Standard, Syracuse, NY"          => [ 92,  110061,      158529],
  "Lexington (KY) Herald-Leader"         => [ 93,  109624,      135250],
  "Morning Call"                         => [ 94,  108797,      140789 ,      "Allentown",            "PA",   ],
  "Journal News"                         => [ 95,  108092,      125829 ,      "West Nyack",           "NY",   ],
  "Philadelphia Daily News"              => [ 96,  107269,           0],
  "Albuquerque Journal"                  => [ 97,  102902,      137623],
  "The State"                            => [ 98,  101010,      128564 ,      "Columbia",             "SC",   ],
  "The Post and Courier"                 => [ 99,  100400,      110289 ,      "Charleston",           "SC",   ],
  "The Daytona Beach News-Journal"       => [100,   99627,      116700],
}
