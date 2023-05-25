//
//  File.swift
//  NanoChallenge2
//
//  Created by Eric Prasetya Sentosa on 24/05/23.
//

import Foundation

struct Food: Identifiable {
    var id = UUID()
    var name: String
    var carbs: Double
    var protein: Double
    var fat: Double
    var calories: Double
}

let foods: [Food] = [
    Food(name: "ayam", carbs: 0.0, protein: 0.21, fat: 0.02, calories: 1.0),
    Food(name: "blueberry-muffin", carbs: 0.52, protein: 0.03, fat: 0.21, calories: 2.39),
    Food(name: "bubur", carbs: 0.14, protein: 0.01, fat: 0.01, calories: 0.68),
    Food(name: "burger", carbs: 0.28, protein: 0.15, fat: 0.18, calories: 2.6),
    Food(name: "chocolate-chip-cookie", carbs: 0.53, protein: 0.05, fat: 0.28, calories: 2.68),
    Food(name: "croissant", carbs: 0.45, protein: 0.08, fat: 0.24, calories: 2.75),
    Food(name: "doughnut", carbs: 0.48, protein: 0.05, fat: 0.26, calories: 2.51),
    Food(name: "es-pisang-ijo", carbs: 0.19, protein: 0.15, fat: 0.0, calories: 0.74),
    Food(name: "french-fries", carbs: 0.48, protein: 0.03, fat: 0.17, calories: 3.06),
    Food(name: "ikan-goreng", carbs: 0.0, protein: 0.2, fat: 0.12, calories: 1.62),
    Food(name: "kacang-mete", carbs: 0.27, protein: 0.05, fat: 0.44, calories: 5.28),
    Food(name: "kangkung", carbs: 0.03, protein: 0.01, fat: 0.0, calories: 0.14),
    Food(name: "klepon", carbs: 0.27, protein: 0.07, fat: 0.05, calories: 1.36),
    Food(name: "kopi-hitam", carbs: 0.0, protein: 0.12, fat: 0.0, calories: 0.5),
    Food(name: "macaroni-cheese", carbs: 0.32, protein: 0.12, fat: 0.08, calories: 1.9),
    Food(name: "martabak-manis", carbs: 0.41, protein: 0.07, fat: 0.1, calories: 2.19),
    Food(name: "mie-ayam", carbs: 0.06, protein: 0.07, fat: 0.02, calories: 0.38),
    Food(name: "nasi-goreng", carbs: 0.13, protein: 0.03, fat: 0.03, calories: 0.79),
    Food(name: "nasi-putih", carbs: 0.08, protein: 0.02, fat: 0.0, calories: 0.39),
    Food(name: "onde-onde", carbs: 0.35, protein: 0.03, fat: 0.04, calories: 1.75),
    Food(name: "pancake", carbs: 0.1, protein: 0.02, fat: 0.02, calories: 0.56),
    Food(name: "pempek", carbs: 0.05, protein: 0.05, fat: 0.02, calories: 0.36),
    Food(name: "pizza", carbs: 0.1, protein: 0.1, fat: 0.09, calories: 1.3),
    Food(name: "red-velvet", carbs: 0.55, protein: 0.02, fat: 0.06, calories: 2.54),
    Food(name: "rendang", carbs: 0.0, protein: 0.17, fat: 0.1, calories: 1.61),
    Food(name: "roti-slice", carbs: 0.15, protein: 0.03, fat: 0.01, calories: 0.81),
    Food(name: "salad", carbs: 0.03, protein: 0.01, fat: 0.01, calories: 0.17),
    Food(name: "salmon", carbs: 0.0, protein: 0.2, fat: 0.13, calories: 1.83),
    Food(name: "sate", carbs: 0.03, protein: 0.08, fat: 0.1, calories: 1.09),
    Food(name: "sayur-asem", carbs: 0.03, protein: 0.02, fat: 0.0, calories: 0.13),
    Food(name: "seafood", carbs: 0.0, protein: 0.2, fat: 0.02, calories: 1.08),
    Food(name: "semangka", carbs: 0.08, protein: 0.01, fat: 0.0, calories: 0.3),
    Food(name: "soto-ayam", carbs: 0.09, protein: 0.02, fat: 0.01, calories: 0.45),
    Food(name: "spaghetti-bolognese", carbs: 0.11, protein: 0.04, fat: 0.03, calories: 0.75),
    Food(name: "steak", carbs: 0.0, protein: 0.22, fat: 0.14, calories: 2.39),
    Food(name: "sushi-makizushi", carbs: 0.19, protein: 0.05, fat: 0.04, calories: 1.05),
    Food(name: "sushi-nigiri", carbs: 0.14, protein: 0.05, fat: 0.03, calories: 0.86),
    Food(name: "telur-balado", carbs: 0.04, protein: 0.11, fat: 0.12, calories: 1.5),
    Food(name: "telur-dadar", carbs: 0.08, protein: 0.13, fat: 0.1, calories: 1.59),
    Food(name: "telur-mata-sapi", carbs: 0.07, protein: 0.13, fat: 0.11, calories: 1.62)
]
