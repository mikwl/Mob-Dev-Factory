import Foundation

typealias DestInfo = (destinationCity: String, distance: Double?, ticketPrice: Double?, hours: Int, minutes: Int)
typealias CityExpectedCostsInfo = (daysInCity: Int?, dailyCost: Int?, nightsForBooking: Int?, costPerNightInHotel: Double?)
typealias CarInfo = (brand: String, model: String, year: Int, fuelConsumptionPer100Km: Double, fuelPricePerLiter: Double, rentPricePerDayEur: Double)
let (krakow, milan, zurich, lyon, paris, brussels, berlin) = ("Krakow", "Milan", "Zurich", "Lyon", "Paris", "Brussels", "Berlin")
let (byBus, byCar, byTrain, byFlight) = ("Bus", "Car", "Train", "Flight")
let carInfo: CarInfo = ("Ford", "Mustang", 1970, 12.2, 1.65, 99.99)

// Транспорт.
var currentTransportationType = String()
let isDriverLicense = true
let noDriverLicenceMessage = "\nКажется у тебя нет водительского удостоверения. Ты не можешь взять авто в аренду. \nПожалуйста, рассмотри другие варианты."
let invalidTransportationType = "Такс, похоже, что мы никуда не едем :("

// Дата и время.
var daysInCity = Int()
var nightsForBooking = Int()
var travelTimeHours = Int()
var travelTimeMinutes = Int()

// Стоимость/Затраты.
var costFuel = Double()
var costForCarRent = Double()
var dailyCost = Double()
var costPerNightInHotel = Double()

// Массивы для записи промежуточных данных
var totalTripTimeHoursArray: [Int] = []
var totalTripTimeMinutesArray: [Int] = []
var totalTripDaysArray: [Int] = []
var totalTripNightsForBookingArray: [Int] = []
var totalTripDailyCostsArray: [Double] = []
var totalTripCostForHotelsArray: [Double] = []
var totalTripTransportationCostsArray: [Double] = []
var totalTripDistanceKmArray: [Double] = []
var totalTripRoutesArray: [String] = []

let cityPopulationDict = [
    krakow: 779_115,
    milan: 1_378_689,
    zurich: 434_008,
    lyon: 515_695,
    paris: 2_206_488,
    brussels: 1_209_784,
    berlin: 3_769_495
]
var cityExpectedCostsInfo: CityExpectedCostsInfo?
let cityExpectedCostsDict: [String: CityExpectedCostsInfo] = [
    krakow: CityExpectedCostsInfo(daysInCity: nil, dailyCost: nil, nightsForBooking: nil, costPerNightInHotel: nil),
    milan: CityExpectedCostsInfo(daysInCity: 3, dailyCost: 50, nightsForBooking: 2, costPerNightInHotel: 65),
    zurich: CityExpectedCostsInfo(daysInCity: 3, dailyCost: 77, nightsForBooking: 2, costPerNightInHotel: 92),
    lyon: CityExpectedCostsInfo(daysInCity: 4, dailyCost: 75, nightsForBooking: 3, costPerNightInHotel: 80),
    paris: CityExpectedCostsInfo(daysInCity: 3, dailyCost: 60, nightsForBooking: 2, costPerNightInHotel: 70),
    brussels: CityExpectedCostsInfo(daysInCity: 4, dailyCost: 60, nightsForBooking: 3, costPerNightInHotel: 65),
    berlin: CityExpectedCostsInfo(daysInCity: 4, dailyCost: 50, nightsForBooking: 3, costPerNightInHotel: 70)
]
var destInfo: DestInfo?
let tripInfoDict: [String: [String: [String: DestInfo]]] = [
    krakow: [
        milan: [
            byBus: DestInfo(destinationCity: milan, distance: 1531.64, ticketPrice: 60.00, hours: 23, minutes: 15),
            byCar: DestInfo(destinationCity: milan, distance: 1312.80, ticketPrice: nil, hours: 13, minutes: 42),
            byTrain: DestInfo(destinationCity: milan, distance: 900.00, ticketPrice: 80.00, hours: 17, minutes: 4),
            byFlight: DestInfo(destinationCity: milan, distance: 900.00, ticketPrice: 24.00, hours: 1, minutes: 55)
        ],
        zurich: [
            byBus: DestInfo(destinationCity: zurich, distance: 1369.67, ticketPrice: 60.00, hours: 33, minutes: 30),
            byCar: DestInfo(destinationCity: zurich, distance: 1174.90, ticketPrice: nil, hours: 20, minutes: 49),
            byTrain: DestInfo(destinationCity: zurich, distance: 900.00, ticketPrice: 80.00, hours: 17, minutes: 4),
            byFlight: DestInfo(destinationCity: zurich, distance: 900.00, ticketPrice: 24.00, hours: 1, minutes: 55)
        ],
        lyon: [
            byBus: DestInfo(destinationCity: lyon, distance: 1952.32, ticketPrice: 60.00, hours: 44, minutes: 45),
            byCar: DestInfo(destinationCity: lyon, distance: 1677.00, ticketPrice: nil, hours: 28, minutes: 8),
            byTrain: DestInfo(destinationCity: lyon, distance: 900.00, ticketPrice: 80.00, hours: 17, minutes: 4),
            byFlight: DestInfo(destinationCity: lyon, distance: 900.00, ticketPrice: 24.00, hours: 1, minutes: 55)
        ],
        paris: [
            byBus: DestInfo(destinationCity: paris, distance: 2181.69, ticketPrice: 60.00, hours: 52, minutes: 0),
            byCar: DestInfo(destinationCity: paris, distance: 1865.00, ticketPrice: nil, hours: 31, minutes: 9),
            byTrain: DestInfo(destinationCity: paris, distance: 900.00, ticketPrice: 80.00, hours: 17, minutes: 4),
            byFlight: DestInfo(destinationCity: paris, distance: 900.00, ticketPrice: 24.00, hours: 1, minutes: 55)
        ],
        brussels: [
            byBus: DestInfo(destinationCity: brussels, distance: 2624.34, ticketPrice: 60.00, hours: 64, minutes: 30),
            byCar: DestInfo(destinationCity: brussels, distance: 2249.60, ticketPrice: nil, hours: 38, minutes: 38),
            byTrain: DestInfo(destinationCity: brussels, distance: 900.00, ticketPrice: 80.00, hours: 17, minutes: 4),
            byFlight: DestInfo(destinationCity: brussels, distance: 900.00, ticketPrice: 24.00, hours: 1, minutes: 55)
        ],
        berlin: [
            byBus: DestInfo(destinationCity: berlin, distance: 1251.39, ticketPrice: 60.00, hours: 30, minutes: 30),
            byCar: DestInfo(destinationCity: berlin, distance: 1068.80, ticketPrice: nil, hours: 18, minutes: 7),
            byTrain: DestInfo(destinationCity: berlin, distance: 900.00, ticketPrice: 80.00, hours: 17, minutes: 4),
            byFlight: DestInfo(destinationCity: berlin, distance: 900.00, ticketPrice: 24.00, hours: 1, minutes: 55)
        ]
    ],
    milan: [
        krakow: [
            byBus: DestInfo(destinationCity: krakow, distance: 1531.64, ticketPrice: 60.00, hours: 23, minutes: 15),
            byCar: DestInfo(destinationCity: krakow, distance: 1312.80, ticketPrice: nil, hours: 13, minutes: 42),
            byTrain: DestInfo(destinationCity: krakow, distance: 900.00, ticketPrice: 80.00, hours: 17, minutes: 4),
            byFlight: DestInfo(destinationCity: krakow, distance: 900.00, ticketPrice: 24.00, hours: 1, minutes: 55)
        ],
        zurich: [
            byBus: DestInfo(destinationCity: zurich, distance: 395.63, ticketPrice: 24.99, hours: 3, minutes: 55),
            byCar: DestInfo(destinationCity: zurich, distance: 339.10, ticketPrice: nil, hours: 4, minutes: 41),
            byTrain: DestInfo(destinationCity: zurich, distance: 280.00, ticketPrice: 32.00, hours: 4, minutes: 17),
            byFlight: DestInfo(destinationCity: zurich, distance: 280.00, ticketPrice: 104.0, hours: 0, minutes: 55)
        ],
        lyon: [
            byBus: DestInfo(destinationCity: lyon, distance: 582.65, ticketPrice: 19.99, hours: 6, minutes: 35),
            byCar: DestInfo(destinationCity: lyon, distance: 499.40, ticketPrice: nil, hours: 5, minutes: 12),
            byTrain: DestInfo(destinationCity: lyon, distance: 460.00, ticketPrice: 80.00, hours: 4, minutes: 22),
            byFlight: DestInfo(destinationCity: lyon, distance: 460.00, ticketPrice: 150.00, hours: 1, minutes: 30)
        ],
        paris: [
            byBus: DestInfo(destinationCity: paris, distance: 548.35, ticketPrice: 9.00, hours: 5, minutes: 45),
            byCar: DestInfo(destinationCity: paris, distance: 470.00, ticketPrice: nil, hours: 5, minutes: 0),
            byTrain: DestInfo(destinationCity: paris, distance: 430.00, ticketPrice: 3.00, hours: 1, minutes: 56),
            byFlight: DestInfo(destinationCity: paris, distance: 430.00, ticketPrice: 109.00, hours: 1, minutes: 10)
        ],
        brussels: [
            byBus: DestInfo(destinationCity: brussels, distance: 442.65, ticketPrice: 12.99, hours: 4, minutes: 15),
            byCar: DestInfo(destinationCity: brussels, distance: 379.40, ticketPrice: nil, hours: 4, minutes: 28),
            byTrain: DestInfo(destinationCity: brussels, distance: 320.00, ticketPrice: 98.00, hours: 1, minutes: 24),
            byFlight: DestInfo(destinationCity: brussels, distance: 320.00, ticketPrice: 114.00, hours: 1, minutes: 5)
        ],
        berlin: [
            byBus: DestInfo(destinationCity: berlin, distance: 886.46, ticketPrice: 24.99, hours: 12, minutes: 10),
            byCar: DestInfo(destinationCity: berlin, distance: 759.80, ticketPrice: nil, hours: 8, minutes: 37),
            byTrain: DestInfo(destinationCity: berlin, distance: 700.00, ticketPrice: 32.00, hours: 6, minutes: 0),
            byFlight: DestInfo(destinationCity: berlin, distance: 700.00, ticketPrice: 24.00, hours: 1, minutes: 25)
        ]
    ],
    zurich: [
        milan: [
            byBus: DestInfo(destinationCity: milan, distance: 280.40, ticketPrice: 35.00, hours: 5, minutes: 30),
            byCar: DestInfo(destinationCity: milan, distance: 250.00, ticketPrice: nil, hours: 4, minutes: 0),
            byTrain: DestInfo(destinationCity: milan, distance: 200.00, ticketPrice: 50.00, hours: 4, minutes: 30),
            byFlight: DestInfo(destinationCity: milan, distance: 200.00, ticketPrice: 120.00, hours: 1, minutes: 15)
        ],
        krakow: [
            byBus: DestInfo(destinationCity: krakow, distance: 1319.30, ticketPrice: 60.00, hours: 23, minutes: 15),
            byCar: DestInfo(destinationCity: krakow, distance: 1131.60, ticketPrice: nil, hours: 13, minutes: 42),
            byTrain: DestInfo(destinationCity: krakow, distance: 900.00, ticketPrice: 80.00, hours: 17, minutes: 4),
            byFlight: DestInfo(destinationCity: krakow, distance: 900.00, ticketPrice: 24.00, hours: 1, minutes: 55)
        ],
        lyon: [
            byBus: DestInfo(destinationCity: lyon, distance: 678.71, ticketPrice: 60.00, hours: 33, minutes: 45),
            byCar: DestInfo(destinationCity: lyon, distance: 580.74, ticketPrice: nil, hours: 23, minutes: 45),
            byTrain: DestInfo(destinationCity: lyon, distance: 460.00, ticketPrice: 80.00, hours: 4, minutes: 22),
            byFlight: DestInfo(destinationCity: lyon, distance: 460.00, ticketPrice: 150.00, hours: 1, minutes: 30)
        ],
        paris: [
            byBus: DestInfo(destinationCity: paris, distance: 634.96, ticketPrice: 60.00, hours: 35, minutes: 30),
            byCar: DestInfo(destinationCity: paris, distance: 541.80, ticketPrice: nil, hours: 22, minutes: 32),
            byTrain: DestInfo(destinationCity: paris, distance: 430.00, ticketPrice: 3.00, hours: 1, minutes: 56),
            byFlight: DestInfo(destinationCity: paris, distance: 430.00, ticketPrice: 109.00, hours: 1, minutes: 10)
        ],
        brussels: [
            byBus: DestInfo(destinationCity: brussels, distance: 865.84, ticketPrice: 60.00, hours: 49, minutes: 45),
            byCar: DestInfo(destinationCity: brussels, distance: 739.80, ticketPrice: nil, hours: 33, minutes: 7),
            byTrain: DestInfo(destinationCity: brussels, distance: 320.00, ticketPrice: 98.00, hours: 1, minutes: 24),
            byFlight: DestInfo(destinationCity: brussels, distance: 320.00, ticketPrice: 114.00, hours: 1, minutes: 5)
        ],
        berlin: [
            byBus: DestInfo(destinationCity: berlin, distance: 691.16, ticketPrice: 60.00, hours: 35, minutes: 30),
            byCar: DestInfo(destinationCity: berlin, distance: 590.20, ticketPrice: nil, hours: 28, minutes: 45),
            byTrain: DestInfo(destinationCity: berlin, distance: 700.00, ticketPrice: 32.00, hours: 6, minutes: 0),
            byFlight: DestInfo(destinationCity: berlin, distance: 700.00, ticketPrice: 24.00, hours: 1, minutes: 25)
        ]
    ],
    lyon: [
        krakow: [
            byBus: DestInfo(destinationCity: krakow, distance: 1531.64, ticketPrice: 60.00, hours: 23, minutes: 15),
            byCar: DestInfo(destinationCity: krakow, distance: 1312.80, ticketPrice: nil, hours: 13, minutes: 42),
            byTrain: DestInfo(destinationCity: krakow, distance: 900.00, ticketPrice: 80.00, hours: 17, minutes: 4),
            byFlight: DestInfo(destinationCity: krakow, distance: 900.00, ticketPrice: 24.00, hours: 1, minutes: 55)
        ],
        paris: [
            byBus: DestInfo(destinationCity: paris, distance: 548.35, ticketPrice: 9.00, hours: 5, minutes: 45),
            byCar: DestInfo(destinationCity: paris, distance: 470.00, ticketPrice: nil, hours: 5, minutes: 0),
            byTrain: DestInfo(destinationCity: paris, distance: 430.00, ticketPrice: 3.00, hours: 1, minutes: 56),
            byFlight: DestInfo(destinationCity: paris, distance: 430.00, ticketPrice: 109.00, hours: 1, minutes: 10)
        ],
        brussels: [
            byBus: DestInfo(destinationCity: brussels, distance: 442.65, ticketPrice: 12.99, hours: 4, minutes: 15),
            byCar: DestInfo(destinationCity: brussels, distance: 379.40, ticketPrice: nil, hours: 4, minutes: 28),
            byTrain: DestInfo(destinationCity: brussels, distance: 320.00, ticketPrice: 98.00, hours: 1, minutes: 24),
            byFlight: DestInfo(destinationCity: brussels, distance: 320.00, ticketPrice: 114.00, hours: 1, minutes: 5)
        ],
        berlin: [
            byBus: DestInfo(destinationCity: berlin, distance: 886.46, ticketPrice: 24.99, hours: 12, minutes: 10),
            byCar: DestInfo(destinationCity: berlin, distance: 759.80, ticketPrice: nil, hours: 8, minutes: 37),
            byTrain: DestInfo(destinationCity: berlin, distance: 700.00, ticketPrice: 32.00, hours: 6, minutes: 0),
            byFlight: DestInfo(destinationCity: berlin, distance: 700.00, ticketPrice: 24.00, hours: 1, minutes: 25)
        ],
        milan: [
            byBus: DestInfo(destinationCity: milan, distance: 582.65, ticketPrice: 19.99, hours: 6, minutes: 35),
            byCar: DestInfo(destinationCity: milan, distance: 499.40, ticketPrice: nil, hours: 5, minutes: 12),
            byTrain: DestInfo(destinationCity: milan, distance: 460.00, ticketPrice: 80.00, hours: 4, minutes: 22),
            byFlight: DestInfo(destinationCity: milan, distance: 460.00, ticketPrice: 150.00, hours: 1, minutes: 30)
        ],
        zurich: [
            byBus: DestInfo(destinationCity: zurich, distance: 395.63, ticketPrice: 24.99, hours: 3, minutes: 55),
            byCar: DestInfo(destinationCity: zurich, distance: 339.10, ticketPrice: nil, hours: 4, minutes: 41),
            byTrain: DestInfo(destinationCity: zurich, distance: 280.00, ticketPrice: 32.00, hours: 4, minutes: 17),
            byFlight: DestInfo(destinationCity: zurich, distance: 280.00, ticketPrice: 104.0, hours: 0, minutes: 55)
        ]
    ],
    paris: [
        krakow: [
            byBus: DestInfo(destinationCity: krakow, distance: 1531.64, ticketPrice: 60.00, hours: 23, minutes: 15),
            byCar: DestInfo(destinationCity: krakow, distance: 1312.80, ticketPrice: nil, hours: 13, minutes: 42),
            byTrain: DestInfo(destinationCity: krakow, distance: 900.00, ticketPrice: 80.00, hours: 17, minutes: 4),
            byFlight: DestInfo(destinationCity: krakow, distance: 900.00, ticketPrice: 24.00, hours: 1, minutes: 55)
        ],
        milan: [
            byBus: DestInfo(destinationCity: milan, distance: 395.63, ticketPrice: 24.99, hours: 3, minutes: 55),
            byCar: DestInfo(destinationCity: milan, distance: 339.10, ticketPrice: nil, hours: 4, minutes: 41),
            byTrain: DestInfo(destinationCity: milan, distance: 280.00, ticketPrice: 32.00, hours: 4, minutes: 17),
            byFlight: DestInfo(destinationCity: milan, distance: 280.00, ticketPrice: 104.0, hours: 0, minutes: 55)
        ],
        zurich: [
            byBus: DestInfo(destinationCity: zurich, distance: 582.65, ticketPrice: 19.99, hours: 6, minutes: 35),
            byCar: DestInfo(destinationCity: zurich, distance: 499.40, ticketPrice: nil, hours: 5, minutes: 12),
            byTrain: DestInfo(destinationCity: zurich, distance: 460.00, ticketPrice: 80.00, hours: 4, minutes: 22),
            byFlight: DestInfo(destinationCity: zurich, distance: 460.00, ticketPrice: 150.00, hours: 1, minutes: 30)
        ],
        lyon: [
            byBus: DestInfo(destinationCity: lyon, distance: 548.35, ticketPrice: 9.00, hours: 5, minutes: 45),
            byCar: DestInfo(destinationCity: lyon, distance: 470.00, ticketPrice: nil, hours: 5, minutes: 0),
            byTrain: DestInfo(destinationCity: lyon, distance: 430.00, ticketPrice: 3.00, hours: 1, minutes: 56),
            byFlight: DestInfo(destinationCity: lyon, distance: 430.00, ticketPrice: 109.00, hours: 1, minutes: 10)
        ],
        brussels: [
            byBus: DestInfo(destinationCity: brussels, distance: 442.65, ticketPrice: 12.99, hours: 4, minutes: 15),
            byCar: DestInfo(destinationCity: brussels, distance: 379.40, ticketPrice: nil, hours: 4, minutes: 28),
            byTrain: DestInfo(destinationCity: brussels, distance: 320.00, ticketPrice: 98.00, hours: 1, minutes: 24),
            byFlight: DestInfo(destinationCity: brussels, distance: 320.00, ticketPrice: 114.00, hours: 1, minutes: 5)
        ],
        berlin: [
            byBus: DestInfo(destinationCity: berlin, distance: 886.46, ticketPrice: 24.99, hours: 12, minutes: 10),
            byCar: DestInfo(destinationCity: berlin, distance: 759.80, ticketPrice: nil, hours: 8, minutes: 37),
            byTrain: DestInfo(destinationCity: berlin, distance: 700.00, ticketPrice: 32.00, hours: 6, minutes: 0),
            byFlight: DestInfo(destinationCity: berlin, distance: 700.00, ticketPrice: 24.00, hours: 1, minutes: 25)
        ]
    ],
    brussels: [
        krakow: [
            byBus: DestInfo(destinationCity: krakow, distance: 1044.72, ticketPrice: 39.99, hours: 17, minutes: 45),
            byCar: DestInfo(destinationCity: krakow, distance: 897.90, ticketPrice: nil, hours: 11, minutes: 32),
            byTrain: DestInfo(destinationCity: krakow, distance: 950.00, ticketPrice: 80.00, hours: 14, minutes: 7),
            byFlight: DestInfo(destinationCity: krakow, distance: 850.00, ticketPrice: 49.50, hours: 1, minutes: 30)
        ],
        milan: [
            byBus: DestInfo(destinationCity: milan, distance: 943.74, ticketPrice: 29.99, hours: 14, minutes: 25),
            byCar: DestInfo(destinationCity: milan, distance: 809.20, ticketPrice: nil, hours: 10, minutes: 50),
            byTrain: DestInfo(destinationCity: milan, distance: 900.00, ticketPrice: 80.00, hours: 17, minutes: 4),
            byFlight: DestInfo(destinationCity: milan, distance: 900.00, ticketPrice: 45.60, hours: 1, minutes: 55)
        ],
        zurich: [
            byBus: DestInfo(destinationCity: zurich, distance: 408.75, ticketPrice: 12.99, hours: 6, minutes: 35),
            byCar: DestInfo(destinationCity: zurich, distance: 349.80, ticketPrice: nil, hours: 4, minutes: 17),
            byTrain: DestInfo(destinationCity: zurich, distance: 320.00, ticketPrice: 32.00, hours: 4, minutes: 17),
            byFlight: DestInfo(destinationCity: zurich, distance: 320.00, ticketPrice: 64.00, hours: 0, minutes: 55)
        ],
        lyon: [
            byBus: DestInfo(destinationCity: lyon, distance: 442.65, ticketPrice: 12.99, hours: 6, minutes: 35),
            byCar: DestInfo(destinationCity: lyon, distance: 379.40, ticketPrice: nil, hours: 4, minutes: 28),
            byTrain: DestInfo(destinationCity: lyon, distance: 320.00, ticketPrice: 98.00, hours: 1, minutes: 24),
            byFlight: DestInfo(destinationCity: lyon, distance: 320.00, ticketPrice: 114.00, hours: 1, minutes: 5)
        ],
        paris: [
            byBus: DestInfo(destinationCity: paris, distance: 320.00, ticketPrice: 12.99, hours: 4, minutes: 15),
            byCar: DestInfo(destinationCity: paris, distance: 320.00, ticketPrice: nil, hours: 4, minutes: 28),
            byTrain: DestInfo(destinationCity: paris, distance: 320.00, ticketPrice: 98.00, hours: 1, minutes: 24),
            byFlight: DestInfo(destinationCity: paris, distance: 320.00, ticketPrice: 114.00, hours: 1, minutes: 5)
        ],
        berlin: [
            byBus: DestInfo(destinationCity: berlin, distance: 1057.56, ticketPrice: 39.99, hours: 17, minutes: 45),
            byCar: DestInfo(destinationCity: berlin, distance: 907.00, ticketPrice: nil, hours: 11, minutes: 32),
            byTrain: DestInfo(destinationCity: berlin, distance: 950.00, ticketPrice: 80.00, hours: 14, minutes: 7),
            byFlight: DestInfo(destinationCity: berlin, distance: 850.00, ticketPrice: 49.50, hours: 1, minutes: 30)
        ]
    ],
    berlin: [
        krakow: [
            byBus: DestInfo(destinationCity: krakow, distance: 699.09, ticketPrice: 31.99, hours: 7, minutes: 15),
            byCar: DestInfo(destinationCity: krakow, distance: 599.20, ticketPrice: nil, hours: 6, minutes: 46),
            byTrain: DestInfo(destinationCity: krakow, distance: 950.00, ticketPrice: 42.00, hours: 14, minutes: 7),
            byFlight: DestInfo(destinationCity: krakow, distance: 850.00, ticketPrice: 41.30, hours: 1, minutes: 15)
        ],
        milan: [
            byBus: DestInfo(destinationCity: milan, distance: 886.46, ticketPrice: 24.99, hours: 12, minutes: 10),
            byCar: DestInfo(destinationCity: milan, distance: 759.80, ticketPrice: nil, hours: 8, minutes: 37),
            byTrain: DestInfo(destinationCity: milan, distance: 700.00, ticketPrice: 32.00, hours: 6, minutes: 0),
            byFlight: DestInfo(destinationCity: milan, distance: 700.00, ticketPrice: 24.00, hours: 1, minutes: 25)
        ],
        zurich: [
            byBus: DestInfo(destinationCity: zurich, distance: 758.31, ticketPrice: 26.99, hours: 9, minutes: 30),
            byCar: DestInfo(destinationCity: zurich, distance: 649.00, ticketPrice: nil, hours: 8, minutes: 16),
            byTrain: DestInfo(destinationCity: zurich, distance: 650.00, ticketPrice: 50.00, hours: 7, minutes: 45),
            byFlight: DestInfo(destinationCity: zurich, distance: 650.00, ticketPrice: 79.99, hours: 1, minutes: 5)
        ],
        lyon: [
            byBus: DestInfo(destinationCity: lyon, distance: 815.00, ticketPrice: 28.99, hours: 10, minutes: 35),
            byCar: DestInfo(destinationCity: lyon, distance: 700.00, ticketPrice: nil, hours: 9, minutes: 15),
            byTrain: DestInfo(destinationCity: lyon, distance: 700.00, ticketPrice: 65.00, hours: 6, minutes: 15),
            byFlight: DestInfo(destinationCity: lyon, distance: 700.00, ticketPrice: 79.99, hours: 1, minutes: 25)
        ],
        paris: [
            byBus: DestInfo(destinationCity: paris, distance: 900.00, ticketPrice: 32.99, hours: 12, minutes: 30),
            byCar: DestInfo(destinationCity: paris, distance: 780.00, ticketPrice: nil, hours: 10, minutes: 0),
            byTrain: DestInfo(destinationCity: paris, distance: 700.00, ticketPrice: 65.00, hours: 6, minutes: 15),
            byFlight: DestInfo(destinationCity: paris, distance: 700.00, ticketPrice: 89.99, hours: 1, minutes: 25)
        ],
        brussels: [
            byBus: DestInfo(destinationCity: brussels, distance: 886.46, ticketPrice: 24.99, hours: 12, minutes: 10),
            byCar: DestInfo(destinationCity: brussels, distance: 759.80, ticketPrice: nil, hours: 8, minutes: 37),
            byTrain: DestInfo(destinationCity: brussels, distance: 700.00, ticketPrice: 32.00, hours: 6, minutes: 0),
            byFlight: DestInfo(destinationCity: brussels, distance: 700.00, ticketPrice: 24.00, hours: 1, minutes: 25)
        ]
    ]
]

enum TransportationType: String {
    case byCar
    case byTrain
    case byPlane
}

struct DestInfo {
    var distance: Double
    var hours: Int
    var minutes: Int
    var ticketPrice: Double
}

struct CityInfo {
    var daysInCity: Int
    var nightsForBooking: Int
    var costPerNightInHotel: Double
    var dailyCost: Double
}

class TripPlanner {
    var tripInfoDict: [String: [String: [TransportationType: DestInfo]]]
    var cityExpectedCostsDict: [String: CityInfo]
    var cityPopulationDict: [String: Int]
    var isDriverLicense: Bool
    var noDriverLicenceMessage = "Требуется водительское удостоверение."

    var totalTripRoutesArray: [String] = []
    var totalTripTransportationCostsArray: [Double] = []
    var totalTripDailyCostsArray: [Double] = []
    var totalTripCostForHotelsArray: [Double] = []
    var totalTripTimeHoursArray: [Int] = []
    var totalTripTimeMinutesArray: [Int] = []
    var totalTripDistanceKmArray: [Double] = []
    var totalTripDaysArray: [Int] = []
    var totalTripNightsForBookingArray: [Int] = []
    var lastPlannedTrip: (from: String, to: String)?

    init() {
        tripInfoDict = [:]
        cityExpectedCostsDict = [:]
        cityPopulationDict = [:]
        isDriverLicense = false
    }

    func getTripInfo(from: String, to: String, transportationType: TransportationType) -> DestInfo? {
        return tripInfoDict[from]?[to]?[transportationType]
    }

    func calculateDistance(fromCity: String, toCity: String, transportationType: TransportationType) -> Double? {
        if let tripInfo = getTripInfo(from: fromCity, to: toCity, transportationType: transportationType) {
            return tripInfo.distance
        }
        return nil
    }

    func calculateTransportationCost(from: String, to: String, transportationType: TransportationType) -> Double {
        guard let distance = calculateDistance(fromCity: from, toCity: to, transportationType: transportationType) else {
            return 0.0
        }

        switch transportationType {
        case .byCar:
            if !isDriverLicense {
                print(noDriverLicenceMessage)
                return 0.0
            } else {
                let costFuel = (distance / 100 * carInfo.fuelConsumptionPer100Km * carInfo.fuelPricePerLiter)
                let costForCarRent = Double(daysInCity) * carInfo.rentPricePerDayEur
                let totalCost = (costFuel + costForCarRent)
                return round(totalCost * 100) / 100
            }
        case .byTrain, .byPlane:
            if let ticketPrice = getTripInfo(from: from, to: to, transportationType: transportationType)?.ticketPrice {
                return ticketPrice
            }
        }
        return 0.0
    }

    func calculateTotalTripCost(from: String, to: String, transportationType: TransportationType) {
        if let lastTrip = lastPlannedTrip, lastTrip.from == from, lastTrip.to == to {
            print("\nТы уже планировал поездку из \(from) в \(to). Пожалуйста, выбери другой город направления.")
            return
        }
        if transportationType == .byCar && !isDriverLicense {
            print("\nТы запланировал поездку из \(from) в \(to) на \(transportationType).", noDriverLicenceMessage)
            return
        }
        totalTripRoutesArray.append("\(from) to \(to)")
        let transportationCost = calculateTransportationCost(from: from, to: to, transportationType: transportationType)
        let dailyExpenses = calculateDailyExpenses(city: to) ?? 0.0
        let hotelCost = calculateHotelCost(city: to) ?? 0.0
        if let tripInfo = getTripInfo(from: from, to: to, transportationType: transportationType) {
            totalTripTransportationCostsArray.append(transportationCost)
            totalTripDailyCostsArray.append(dailyExpenses)
            totalTripCostForHotelsArray.append(hotelCost)
            totalTripTimeHoursArray.append(tripInfo.hours)
            totalTripTimeMinutesArray.append(tripInfo.minutes)
            totalTripDistanceKmArray.append(tripInfo.distance)
            totalTripDaysArray.append(cityExpectedCostsDict[to]?.daysInCity ?? 0)
            totalTripNightsForBookingArray.append(cityExpectedCostsDict[to]?.nightsForBooking ?? 0)
            lastPlannedTrip = (from: from, to: to)
            let tripDescriptionText = generateTripDescriptionText(from: from, to: to, transportationType: transportationType, tripInfo: tripInfo, destinationCity: to, transportationCost: transportationCost, dailyExpenses: dailyExpenses, hotelCost: hotelCost)
            print(tripDescriptionText)
        } else {
            print("\nError in trip planning! Please check the data.")
        }
    }

    func generateTripDescriptionText(from: String, to: String, transportationType: TransportationType, tripInfo: DestInfo, destinationCity: String, transportationCost: Double, dailyExpenses: Double, hotelCost: Double) -> String {
        let cityPopulation = cityPopulationDict[destinationCity] ?? 0
        return """
        \nТы запланировал поездку \(from) - \(to) на \(transportationType). Расстояние между городами: \(tripInfo.distance) км.
        Время в пути составит \(tripInfo.hours) ч \(tripInfo.minutes) мин. Стоимость проезда: \(transportationCost) EUR.
        В \(to) планируется провести \(cityExpectedCostsDict[to]?.daysInCity ?? 0) дней, и \(cityExpectedCostsDict[to]?.nightsForBooking ?? 0) ночей в отеле.
        Затраты на это составят \(dailyExpenses) EUR и \(hotelCost) EUR соответственно.
        Общие затраты на этот маршрут составят: \(transportationCost + dailyExpenses + hotelCost) EUR.
        """
    }

    func calculateDailyExpenses(city: String) -> Double? {
        guard let cityInfo = cityExpectedCostsDict[city],
              let days = cityInfo.daysInCity,
              let dailyCost = cityInfo.dailyCost else {
            return nil
        }
        return Double(days) * Double(dailyCost)
    }

    func calculateHotelCost(city: String) -> Double? {
        guard let cityInfo = cityExpectedCostsDict[city],
              let nights = cityInfo.nightsForBooking,
              let costPerNight = cityInfo.costPerNightInHotel else {
            return nil
        }
        return Double(nights) * costPerNight
    }

    func getTimeBetweenCities(fromCity: String, toCity: String, transportationType: TransportationType) -> (hours: Int, minutes: Int)? {
        if let tripInfo = getTripInfo(from: fromCity, to: toCity, transportationType: transportationType) {
            return (tripInfo.hours, tripInfo.minutes)
        }
        return nil
    }

    func convertToHoursMinutes(hours: Int, minutes: Int) -> String {
        return "\(hours + (minutes / 60)) часов \(minutes % 60) минут"
    }

    func printTotalTripInfo() {
        let totalTravelTimeHoursWithMinutes = convertToHoursMinutes(hours: totalTripTimeHoursArray.reduce(0, +), minutes: totalTripTimeMinutesArray.reduce(0, +))
        let finalBookingCosts = totalTripCostForHotelsArray.reduce(0.0, +)
        let finalTripDailyCosts = totalTripDailyCostsArray.reduce(0.0, +)
        let finalTripTransportationCosts = totalTripTransportationCostsArray.reduce(0.0, +)
        let finalTripDistance = round(totalTripDistanceKmArray.reduce(0.0, +))
        let finalDaysInTrip = totalTripDaysArray.reduce(0, +)
        let finalNightsForBookingInTrip = totalTripNightsForBookingArray.reduce(0, +)
        print("\nИтоговый отчёт по всей поездке: \n")
        print("Пройденные маршруты: \(totalTripRoutesArray.joined(separator: ", "))")
        print("Преодолённая дистанция: \(finalTripDistance) км")
        print("Время, проведённое в дороге: \(totalTravelTimeHoursWithMinutes)")
        print("Всего дней: \(finalDaysInTrip)")
        print("Всего ночей в отелях: \(finalNightsForBookingInTrip)")
        print("Всего потрачено на бронирование отелей: \(finalBookingCosts) EUR")
        print("Всего потрачено на кафе, музеи, сувениры и развлечения: \(finalTripDailyCosts) EUR")
        print("Всего потрачено на транспорт: \(finalTripTransportationCosts) EUR")
        print("\nИ Т О Г О будет потрачено: \(finalBookingCosts + finalTripDailyCosts + finalTripTransportationCosts)")
    }
}

// Пример использования:

var tripPlanner = TripPlanner()
tripPlanner.calculateTotalTripCost(from: krakow, to: paris, transportationType: .byCar)
tripPlanner.printTotalTripInfo()
