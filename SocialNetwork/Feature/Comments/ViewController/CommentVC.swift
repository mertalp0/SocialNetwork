//
//  CommentVC.swift
//  SocialNetwork
//
//  Created by mert alp on 4.11.2024.
//

import UIKit
import SnapKit
import NeonSDK

final class CommentVC: BaseVC<CommentViewModel> {
    
    private let appBar = SettingsAppBar(title: "Comment")
    private var sendButton: CustomButton!
    private var tableView: UITableView!
    private var noCommentsLabel: UILabel!
    private var commentInputView: UIView!
    private var profileImageView: UIImageView!
    private var commentTextField: UITextField!
    
    private var user: AppUser? {
        return UserManager.shared.currentUser
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupCommentInputView()
        setupTableView()
        setupSendButton()
        
        fetchComments()
    }
    
    private func setupUI() {
        view.addSubview(appBar)
        appBar.delegate = self
        appBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    private func setupCommentInputView() {
        commentInputView = UIView()
        commentInputView.backgroundColor = .white
        view.addSubview(commentInputView)
        
        profileImageView = UIImageView()
        profileImageView.layer.cornerRadius = .cornerRadius
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        if let userImageUrl = user?.profileImageUrl, let url = URL(string: userImageUrl) {
            profileImageView.kf.setImage(with: url)
        } else {
            profileImageView.image = UIImage(named: "Mert")
        }
        commentInputView.addSubview(profileImageView)
        
        commentTextField = UITextField()
        commentTextField.placeholder = "Write a comment..."
        commentTextField.borderStyle = .none
        
        commentInputView.addSubview(commentTextField)
        
        commentInputView.snp.makeConstraints { make in
            make.top.equalTo(appBar.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(160)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        commentTextField.snp.makeConstraints { make in
            make.left.equalTo(profileImageView.snp.right).offset(12)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(16)
        }
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.register(CommentCell.self, forCellReuseIdentifier: "CommentCell")
        tableView.dataSource = self
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(commentInputView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(60)
        }
        
        noCommentsLabel = UILabel()
        noCommentsLabel.text = "No comments yet."
        noCommentsLabel.textAlignment = .center
        noCommentsLabel.textColor = .gray
        noCommentsLabel.font = .systemFont(ofSize: 16)
        view.addSubview(noCommentsLabel)
        
        noCommentsLabel.snp.makeConstraints { make in
            make.center.equalTo(tableView)
        }
        
        updateNoCommentsLabelVisibility()
    }
    
    private func setupSendButton() {
        sendButton = CustomButton(title: "Send", backgroundColor: .primaryColor, type: .large, textColor: .white)
        sendButton.delegate = self
        view.addSubview(sendButton)
        
        sendButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-15)
            make.centerX.equalToSuperview()
        }
    }
    
    private func fetchComments() {
        guard let commentIds = viewModel.post?.commenters else { return }
        viewModel.fetchComments(commentIds: commentIds) { [weak self] success in
            if success {
                self?.tableView.reloadData()
                self?.updateNoCommentsLabelVisibility()
            } else {
                print("Failed to fetch comments")
            }
        }
    }
    
    private func updateNoCommentsLabelVisibility() {
        noCommentsLabel.isHidden = !viewModel.comments.isEmpty
    }
}

// MARK: - UITableViewDataSource
extension CommentVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        let comment = viewModel.comments[indexPath.row]
        cell.configure(with: comment)
        return cell
    }
}

// MARK: - SettingsAppBarDelegate
extension CommentVC: SettingsAppBarDelegate {
    func didTapBackButton() {
        self.dismiss(animated: true)
    }
}

//MARK: - CustomButtonDelegate
extension CommentVC: CustomButtonDelegate {
    func customButtonDidTap(_ button: CustomButton) {
        guard let commentText = commentTextField.text, !commentText.isEmpty else {
            print("Comment text is empty")
            return
        }
        
        viewModel.pushComment(text: commentText) { [weak self] success in
            if success {
                self?.fetchComments()
                self?.commentTextField.text = ""
                self?.tableView.reloadData()
            } else {
                print("Failed to send comment")
            }
        }
    }
}
