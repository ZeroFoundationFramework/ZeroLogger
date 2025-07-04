//
//  Logger.swift
//  zero_proj
//
//  Created by Philipp Kotte on 05.07.25.
//

import Foundation

public final class Logger: Sendable {
    public enum Level: String {
        case info = "INFO"
        case warning = "WARN"
        case error = "ERROR"
        case dev = "DEV" // Neues Level für Entwicklungs-Logs

        /// Gibt den ANSI-Farbcode für das jeweilige Log-Level zurück.
        var colorCode: String {
            switch self {
            case .info: return "\u{001B}[34m"    // Blau
            case .warning: return "\u{001B}[33m" // Gelb
            case .error: return "\u{001B}[31m"   // Rot
            case .dev: return "\u{001B}[32m"     // Grün
            }
        }
    }

    nonisolated(unsafe) private static let iso8601Formatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()

    private let label: String

    public init(label: String) {
        self.label = label
    }

    public func info(_ message: String) {
        log(level: .info, message: message)
    }

    public func warning(_ message: String) {
        log(level: .warning, message: message)
    }

    public func error(_ message: String) {
        log(level: .error, message: message)
    }
    
    public func dev(_ message: String) {
        log(level: .dev, message: message)
    }

    private func log(level: Level, message: String) {
        let timestamp = Self.iso8601Formatter.string(from: Date())
        // Füge den Farbcode am Anfang und einen Reset-Code am Ende hinzu.
        let resetCode = "\u{001B}[0m"
        print("\(level.colorCode)[\(timestamp)] [\(level.rawValue)] [\(label)]: \(message)\(resetCode)")
    }
}
