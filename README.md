# SkillRewards

SkillRewards is a blockchain-based professional development tracking system built on the Stacks blockchain that records skill advancement and distributes rewards to incentivize continuous learning.

## Features

- **Milestone Tracking**: Record and verify skill development milestones on the blockchain
- **Proportional Rewards**: Earn rewards based on your contribution to the overall skill pool
- **Transparent Distribution**: Fair and transparent bonus allocation for professional growth
- **Immutable Records**: Blockchain-based records ensure professional development accountability

## Smart Contract Functions

### Administration
- `launch-development-program`: Set up the SkillRewards system with a development manager
- `distribute-growth-bonuses`: Calculate and distribute bonus points based on time elapsed

### Professional Functions
- `record-skill-milestones`: Record new skill milestones and add them to your total progress
- `claim-development-rewards`: Claim your accumulated progress and proportional bonuses

## Getting Started

1. Clone this repository
2. Install [Clarinet](https://github.com/hirosystems/clarinet) for local development
3. Run `clarinet check` to verify the contract
4. Deploy using Clarinet or the Stacks CLI

## For Professionals

Professionals can record their skill development milestones and claim rewards proportional to their contribution to the overall professional growth community.

## For Organizations

Organizations can use this system to incentivize consistent professional development and create a competitive yet supportive learning environment.

## Technical Details

- Skill milestones are tracked per professional address
- Bonuses accumulate over time based on block height
- Rewards are distributed proportionally based on contribution to the skill pool
- All transactions are recorded on the Stacks blockchain for transparency