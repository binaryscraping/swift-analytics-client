public struct AnalyticsEvent: Hashable, Codable, Identifiable {
  public var id: String { name }

  public var name: String
  public var properites: [String: String]?

  public init(name: String, properties: [String: String]? = nil) {
    self.name = name
    self.properites = properties
  }
}

public struct AnalyticsClient {
  public var track: (_ event: AnalyticsEvent) -> Void

  public init(track: @escaping (_ event: AnalyticsEvent) -> Void) {
    self.track = track
  }

  /// The default client implementation that sends the event to multiple provided destinations.
  /// - Parameter destinations: Destinations to send the event to.
  /// - Returns: The default analytics client.
  public static func `default`(_ destinations: [AnalyticsDestination]) -> AnalyticsClient {
    AnalyticsClient { event in
      for destination in destinations {
        destination.send(event)
      }
    }
  }
}

/// A Destination where ``AnalyticsEvent`` can be sent to, for example, console, file, remote database, proprietary services like Crashlytics.
public struct AnalyticsDestination {
  public var send: (_ event: AnalyticsEvent) -> Void

  public init(send: @escaping (_ event: AnalyticsEvent) -> Void) {
    self.send = send
  }
}

extension AnalyticsDestination {
  /// A destination implementation that prints events to the console, only in debug builds.
  public static var console: AnalyticsDestination {
    AnalyticsDestination { event in
      #if DEBUG
        print("[Analytics] Tracked event \(event.name) with properties \(event.properites ?? [:])")
      #endif
    }
  }
}
