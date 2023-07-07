//
//  MediaViewController.swift
//  GAP International
//
//  Created by Yogesh on 6/20/23.
//

import UIKit
import Foundation
import AVFoundation
import WebKit

class MediaViewController: UIViewController, WKNavigationDelegate {
    
    var delegate: ChpVcDelegate?
    var client = ClientManager()
    var player: AVPlayer!
    var link: String = "google.com" {
        didSet {
            self.refreshData()
        }
    }
    var username : String! {
        didSet{
            print("MVC Value Changed to", username ?? "")
        }
    }
    var chpName: String = "" {
        didSet{
            print("MVC ChapterName Value Changed to", chpName)
        }
    }
    var allDetails : [JournalDetails] = []
    
    var playerItem: AVPlayerItem!
    var playerLayer: AVPlayerLayer!
    var playPauseButton: UIButton!
    var forwardButton: UIButton!
    var backwardButton: UIButton!
    var progressView: UIProgressView!
    var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        refreshData()
    }
    func refreshData() {
        // Create the AVPlayerItem with the video URL
        if let player = player {
            player.pause()
        }
        let videoURL = URL(string: link)
        playerItem = AVPlayerItem(url: videoURL!)
        
        
        // Create the AVPlayer with the player item
        player = AVPlayer(playerItem: playerItem)
        player.pause()
        
        // Create the AVPlayerLayer to display the video
        playerLayer = AVPlayerLayer(player: player)
        view.layer.addSublayer(playerLayer)
        
        // Create the play/pause button
        playPauseButton = UIButton(type: .system)
        playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        playPauseButton.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
        
        // Create the forward button
        forwardButton = UIButton(type: .system)
        forwardButton.setImage(UIImage(systemName: "forward.end.fill"), for: .normal)
        forwardButton.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
        
        // Create the backward button
        backwardButton = UIButton(type: .system)
        backwardButton.setImage(UIImage(systemName: "backward.end.fill"), for: .normal)
        backwardButton.addTarget(self, action: #selector(backwardButtonTapped), for: .touchUpInside)
        
        
        // Create the progress view
        progressView = UIProgressView(progressViewStyle: .default)
        
        
        // Create the horizontal stack view
        stackView = UIStackView(arrangedSubviews: [backwardButton, playPauseButton, forwardButton, progressView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10.0
        stackView.backgroundColor = .white
        view.addSubview(stackView)
        
        // Add constraints to position the stack view
        let constraints = [
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        // Observe the time updates of the player
        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.1, preferredTimescale: CMTimeScale(NSEC_PER_SEC)), queue: DispatchQueue.main) { [weak self] time in
            let currentTime = CMTimeGetSeconds(time)
            let totalTime = CMTimeGetSeconds(self?.playerItem.duration ?? .zero)
            
            // Update the progress view
            self?.progressView.setProgress(Float(currentTime / totalTime), animated: true)
        }
        
        // Start playing the video
        player.play()
        
        // Register observer for the video end notification
        NotificationCenter.default.addObserver(self, selector: #selector(videoDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Update the frame of the playerLayer to fit the current size of the detail view controller
        playerLayer.frame = view.bounds
    }
    
    @objc func videoDidFinishPlaying() {
        // Show an alert to add a comment
        let alertController = UIAlertController(title: "Add Comment", message: "Please enter your comment:", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Comment"
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let comment = alertController.textFields?.first?.text else { return }
            self?.saveComment(comment)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    func saveComment(_ comment: String) {
    
            DispatchQueue.main.async {
                print("Received comment: \(comment)")
                print("MVC 2 Username = ", self.username!)
                let url = saveJounalUrl
                
                self.client.saveJournalProgress(url: url!, username: self.username, chpName: self.chpName, comment: comment, level: 1, completion: { ans in
                    print(ans)
                    self.delegate?.commentSaved()
                })
                
            }
        }
    
    
    
    @objc func playPauseButtonTapped() {
        if player.rate == 0 {
            // Video is paused, so play it
            player.play()
            playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        } else {
            // Video is playing, so pause it
            player.pause()
            playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
    @objc func forwardButtonTapped() {
        let currentTime = player.currentTime()
        let newTime = CMTimeAdd(currentTime, CMTime(seconds: 10.0, preferredTimescale: currentTime.timescale))
        player.seek(to: newTime)
    }
    
    @objc func backwardButtonTapped() {
        let currentTime = player.currentTime()
        let newTime = CMTimeSubtract(currentTime, CMTime(seconds: 10.0, preferredTimescale: currentTime.timescale))
        player.seek(to: newTime)
    }
    
    deinit {
        // Remove the observer when the view controller is deallocated
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
}




