import Foundation
import WebRTC

internal protocol SignalClientDelegate {

    func signalClient(_ signalClient: SignalClient, didUpdate connectionState: ConnectionState) -> Bool
    func signalClient(_ signalClient: SignalClient, didReceive joinResponse: Livekit_JoinResponse) -> Bool
    func signalClient(_ signalClient: SignalClient, didReceiveAnswer answer: RTCSessionDescription) -> Bool
    func signalClient(_ signalClient: SignalClient, didReceiveOffer offer: RTCSessionDescription) -> Bool
    func signalClient(_ signalClient: SignalClient, didReceive iceCandidate: RTCIceCandidate, target: Livekit_SignalTarget) -> Bool
    func signalClient(_ signalClient: SignalClient, didPublish localTrack: Livekit_TrackPublishedResponse) -> Bool
    func signalClient(_ signalClient: SignalClient, didUpdate participants: [Livekit_ParticipantInfo]) -> Bool
    func signalClient(_ signalClient: SignalClient, didUpdate room: Livekit_Room) -> Bool
    func signalClient(_ signalClient: SignalClient, didUpdate speakers: [Livekit_SpeakerInfo]) -> Bool
    func signalClient(_ signalClient: SignalClient, didUpdate connectionQuality: [Livekit_ConnectionQualityInfo]) -> Bool
    func signalClient(_ signalClient: SignalClient, didUpdateRemoteMute trackSid: String, muted: Bool) -> Bool
    func signalClient(_ signalClient: SignalClient, didUpdate trackStates: [Livekit_StreamStateInfo]) -> Bool
    func signalClient(_ signalClient: SignalClient, didUpdate trackSid: String, subscribedQualities: [Livekit_SubscribedQuality]) -> Bool
    func signalClient(_ signalClient: SignalClient, didUpdate subscriptionPermission: Livekit_SubscriptionPermissionUpdate) -> Bool
    func signalClient(_ signalClient: SignalClient, didUpdate token: String) -> Bool
    func signalClient(_ signalClient: SignalClient, didReceiveLeave canReconnect: Bool) -> Bool
}

// MARK: - Optional

extension SignalClientDelegate {

    func signalClient(_ signalClient: SignalClient, didUpdate connectionState: ConnectionState) -> Bool { false }
    func signalClient(_ signalClient: SignalClient, didReceive joinResponse: Livekit_JoinResponse) -> Bool { false }
    func signalClient(_ signalClient: SignalClient, didReceiveAnswer answer: RTCSessionDescription) -> Bool { false }
    func signalClient(_ signalClient: SignalClient, didReceiveOffer offer: RTCSessionDescription) -> Bool { false }
    func signalClient(_ signalClient: SignalClient, didReceive iceCandidate: RTCIceCandidate, target: Livekit_SignalTarget) -> Bool { false }
    func signalClient(_ signalClient: SignalClient, didPublish localTrack: Livekit_TrackPublishedResponse) -> Bool { false }
    func signalClient(_ signalClient: SignalClient, didUpdate participants: [Livekit_ParticipantInfo]) -> Bool { false }
    func signalClient(_ signalClient: SignalClient, didUpdate room: Livekit_Room) -> Bool { false }
    func signalClient(_ signalClient: SignalClient, didUpdate speakers: [Livekit_SpeakerInfo]) -> Bool { false }
    func signalClient(_ signalClient: SignalClient, didUpdate connectionQuality: [Livekit_ConnectionQualityInfo]) -> Bool { false }
    func signalClient(_ signalClient: SignalClient, didUpdateRemoteMute trackSid: String, muted: Bool) -> Bool { false }
    func signalClient(_ signalClient: SignalClient, didUpdate trackStates: [Livekit_StreamStateInfo]) -> Bool { false }
    func signalClient(_ signalClient: SignalClient, didUpdate trackSid: String, subscribedQualities: [Livekit_SubscribedQuality]) -> Bool { false }
    func signalClient(_ signalClient: SignalClient, didUpdate subscriptionPermission: Livekit_SubscriptionPermissionUpdate) -> Bool { false }
    func signalClient(_ signalClient: SignalClient, didUpdate token: String) -> Bool { false }
    func signalClient(_ signalClient: SignalClient, didReceiveLeave canReconnect: Bool) -> Bool { false }
}

// MARK: - Closures

class SignalClientDelegateClosures: NSObject, SignalClientDelegate, Loggable {

    typealias DidUpdateConnectionState = (SignalClient, ConnectionState) -> Bool
    typealias DidReceiveJoinResponse = (SignalClient, Livekit_JoinResponse) -> Bool
    typealias DidPublishLocalTrack = (SignalClient, Livekit_TrackPublishedResponse) -> Bool

    let didUpdateConnectionState: DidUpdateConnectionState?
    let didReceiveJoinResponse: DidReceiveJoinResponse?
    let didPublishLocalTrack: DidPublishLocalTrack?

    init(didUpdateConnectionState: DidUpdateConnectionState? = nil,
         didReceiveJoinResponse: DidReceiveJoinResponse? = nil,
         didPublishLocalTrack: DidPublishLocalTrack? = nil) {

        self.didUpdateConnectionState = didUpdateConnectionState
        self.didReceiveJoinResponse = didReceiveJoinResponse
        self.didPublishLocalTrack = didPublishLocalTrack
        super.init()
        log()
    }

    deinit {
        log()
    }

    func signalClient(_ signalClient: SignalClient, didUpdate connectionState: ConnectionState) -> Bool {
        return didUpdateConnectionState?(signalClient, connectionState) ?? false
    }

    func signalClient(_ signalClient: SignalClient, didReceive joinResponse: Livekit_JoinResponse) -> Bool {
        return didReceiveJoinResponse?(signalClient, joinResponse) ?? false
    }

    func signalClient(_ signalClient: SignalClient, didPublish localTrack: Livekit_TrackPublishedResponse) -> Bool {
        return didPublishLocalTrack?(signalClient, localTrack) ?? false
    }
}
