//
//  Logger.swift
//  zero_proj
//
//  Created by Philipp Kotte on 05.07.25.
//

import Foundation

public final class Logger {
    public enum Level: String {
        case info = "INFO"
        case warning = "WARN"
        case error = "ERROR"
    }

    // HIER IST DIE ÄNDERUNG:
    // Wir erstellen einen einzigen, wiederverwendbaren Formatter.
    // Das ist performanter und abwärtskompatibel.
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

    private func log(level: Level, message: String) {
        // HIER IST DIE ÄNDERUNG:
        // Wir verwenden jetzt den robusten Formatter.
        let timestamp = Self.iso8601Formatter.string(from: Date())
        print("[\(timestamp)] [\(level.rawValue)] [\(label)]: \(message)")
    }
}
