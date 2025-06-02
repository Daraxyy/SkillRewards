;; SkillRewards: Professional Development Tracking System
;; Version: 1.0.0

(define-data-var development-manager principal tx-sender)
(define-data-var skill-pool uint u0)
(define-data-var growth-bonus uint u85) ;; bonus points added per block
(define-data-var bonus-timestamp uint u0) ;; last block when bonuses were calculated
(define-map professional-progress principal uint)

;; Helper function to ensure only the development manager can perform certain actions
(define-private (is-manager (caller principal))
  (begin
    (asserts! (is-eq caller (var-get development-manager)) (err u600))
    (ok true)))

;; Initialize the professional development system
(define-public (launch-development-program (manager principal))
  (begin
    (asserts! (is-none (map-get? professional-progress manager)) (err u601))
    (var-set development-manager manager)
    (ok "SkillRewards development program launched")))

;; Add skill development milestones to the system
(define-public (record-skill-milestones (milestones uint))
  (begin
    (asserts! (> milestones u0) (err u602))
    (let ((current-progress (default-to u0 (map-get? professional-progress tx-sender))))
      (map-set professional-progress tx-sender (+ current-progress milestones))
      (var-set skill-pool (+ (var-get skill-pool) milestones))
      (ok (+ current-progress milestones)))))

;; Calculate growth bonuses for all professionals
(define-public (distribute-growth-bonuses)
  (begin
    (try! (is-manager tx-sender))
    (let ((current-block tenure-height)
          (previous-update (var-get bonus-timestamp)))
      (asserts! (> current-block previous-update) (err u603))
      ;; Calculate bonuses based on blocks elapsed
      (let ((elapsed (- current-block previous-update))
            (total-bonus (* elapsed (var-get growth-bonus))))
        (var-set bonus-timestamp current-block)
        (var-set skill-pool (+ (var-get skill-pool) total-bonus))
        (ok total-bonus)))))

;; Claim skill development progress and bonuses
(define-public (claim-development-rewards)
  (begin
    (let ((professional-achievement (default-to u0 (map-get? professional-progress tx-sender))))
      (asserts! (> professional-achievement u0) (err u604))
      (let ((total-progress (var-get skill-pool))
            (total-bonus (* (var-get growth-bonus) (- tenure-height (var-get bonus-timestamp))))
            (proportion (/ (* professional-achievement u100000) total-progress)))
        ;; Update progress and calculate bonus proportion
        (let ((bonus-portion (/ (* proportion total-bonus) u100000)))
          (map-delete professional-progress tx-sender)
          (var-set skill-pool (- (var-get skill-pool) professional-achievement))
          (ok (+ professional-achievement bonus-portion)))))))