;; Define the contract
(define-constant CONTRACT_OWNER (as-contract tx-sender))

;; Data structures
(define-data-var campaign-id uint u0)

(define-map campaigns
    uint ;; campaign ID
    { 
        owner: principal,
        goal: uint,
        deadline: uint,
        pledged: uint,
        claimed: bool
    }
)

(define-map pledges
    (tuple (campaign-id uint) (contributor principal))
    uint ;; amount pledged
)

;; Error codes
(define-constant ERR_CAMPAIGN_NOT_FOUND (err u1001))
(define-constant ERR_CAMPAIGN_ENDED (err u1002))
(define-constant ERR_GOAL_REACHED (err u1003))
(define-constant ERR_INVALID_AMOUNT (err u1004))
(define-constant ERR_UNAUTHORIZED (err u1005))
(define-constant ERR_FUNDS_ALREADY_CLAIMED (err u1006))
(define-constant ERR_GOAL_NOT_MET (err u1007))
(define-constant ERR_WITHDRAWAL_NOT_ALLOWED (err u1008))

;; Helper functions
(define-private (get-current-block-height) block-height)

(define-private (campaign-exists? (id uint))
    (is-some (map-get? campaigns id))
)

(define-private (is-campaign-active? (id uint))
    (match (map-get? campaigns id)
        campaign (< (get-current-block-height) (get deadline campaign))
        false
    )
)

(define-private (is-goal-met? (id uint))
    (match (map-get? campaigns id)
        campaign (>= (get pledged campaign) (get goal campaign))
        false
    )
)

;; Create a new campaign
(define-public (create-campaign (goal uint) (deadline uint))
    (let ((new-id (+ (var-get campaign-id) u1)))
        (asserts! (> goal u0) ERR_INVALID_AMOUNT)
        (asserts! (> deadline (get-current-block-height)) ERR_CAMPAIGN_ENDED)
        (map-set campaigns new-id {
            owner: tx-sender,
            goal: goal,
            deadline: deadline,
            pledged: u0,
            claimed: false
        })
        (var-set campaign-id new-id)
        (ok new-id)
    )
)

;; Pledge to a campaign
(define-public (pledge (id uint) (amount uint))
    (let ((campaign (unwrap! (map-get? campaigns id) ERR_CAMPAIGN_NOT_FOUND)))
        (asserts! (is-campaign-active? id) ERR_CAMPAIGN_ENDED)
        (asserts! (not (is-goal-met? id)) ERR_GOAL_REACHED)
        (asserts! (> amount u0) ERR_INVALID_AMOUNT)
        (map-set pledges (tuple (campaign-id id) (contributor tx-sender)) amount)
        (map-set campaigns id (merge campaign {
            pledged: (+ (get pledged campaign) amount)
        }))
        (ok true)
    )
)

;; Withdraw pledge if the goal is not met
(define-public (withdraw-pledge (id uint))
    (let ((campaign (unwrap! (map-get? campaigns id) ERR_CAMPAIGN_NOT_FOUND))
          (pledge-amount (unwrap! (map-get? pledges (tuple (campaign-id id) (contributor tx-sender))) ERR_UNAUTHORIZED)))
        (asserts! (not (is-campaign-active? id)) ERR_WITHDRAWAL_NOT_ALLOWED)
        (asserts! (not (is-goal-met? id)) ERR_GOAL_NOT_MET)
        (map-delete pledges (tuple (campaign-id id) (contributor tx-sender)))
        (map-set campaigns id (merge campaign {
            pledged: (- (get pledged campaign) pledge-amount)
        }))
        (ok true)
    )
)

;; Claim funds if the goal is met
(define-public (claim-funds (id uint))
    (let ((campaign (unwrap! (map-get? campaigns id) ERR_CAMPAIGN_NOT_FOUND)))
        (asserts! (is-goal-met? id) ERR_GOAL_NOT_MET)
        (asserts! (not (get claimed campaign)) ERR_FUNDS_ALREADY_CLAIMED)
        (asserts! (is-eq tx-sender (get owner campaign)) ERR_UNAUTHORIZED)
        (map-set campaigns id (merge campaign {
            claimed: true
        }))
        (ok true)
    )
)