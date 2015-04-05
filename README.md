# Adjective

The main point of this project is to practice writing code using the Rails framework. My eventual goal is to design and deploy a working alpha version in the near future.

The game itself is based upon a simple premise: You are either an adventurer or one of the bosses that stand in their way. Players will be organized in to a party of 3-4 (still figuring out balancing for the exact number...) with one boss (and the possibility of minions for specific builds) on the opposing side. Once the party wipes or the boss is dead, the match is over. Players will collect EXP and items to power themselves up, and bosses will do the same.

## Players and Bosses


I decided to go with an extremely open-ended design pattern when it comes to actual playable entities. There is no standard class-based system like many traditional RPGs enforce. Instead, the stats of each character or boss is what determines the moveset that is available to the character. However, this will be enforced by only having a certain number of move slots to work with. I plan to include passive and active effects as well. 

For example, the character Azorius has a stat spread of 5 strength, 2 agility, 1 intellect, and 4 faith. This character, in traditional RPG terms, may classify as a Paladin or Crusader class. With 5 strength, the character has access to powerful moves like Overhead Smash (5 str requirement) while also having access to Heal (3 faith requirement). However, having low intellect means that his acuity (magic defense, basically) will be low. Also, having 2 in Agility unlocks the passive ability 'dodge' which gives a small chance to completely avoid attacks.

**The entire point of this system is to have me get out of the way and let others devise their own strategies.** It's a lot more fun that way. I am a HUGE fan of Dark Souls, and I feel like their model for character 'growth' is about as complete and enthralling as it gets. It is a little harder to get in to initially, but once you understand the mechanics past basic speculation, it opens metaphorical doors as far as creativity and balance go. 

## Combat

Combat is the entire reason that this game exists in the first place. I am planning on modeling it after a fairly traditional JRPG with multiplayer functionality.

The game will play out as a turn-based RPG. Each entity will be sorted and put in to a turn order queue. Primarily because people hate waiting, all moves will be submitted at the same time and the turn order will play out in explicit order. Certain mechanics, like a Raison d'être, will interrupt the turn cycle. Certain moves like Swift Strike will always go first.

I am also adding a true damage mechanic to some higher-level moves because, quite honestly, dumping all of your stats in to avoidance, going 100% hit-chance or heavy status-inducing moves, and neglecting to build health is simply unhealthy as far as combat design goes. My goal is to have a counter for everything even if it isn't perfectly apparent to newer players.

## Other Notes
__I am toying with the idea of having a level cap. These design decisions are hardly meant to be considered this early in the project and are more suited for a blog.__
