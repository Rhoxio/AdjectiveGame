# Adjective

### Be sure to check out the actual code! Much of it is annotated and there are some creative solutions to status effects and things of that nature. 

The main point of this project is to practice writing code using the Rails framework. My eventual goal is to design and deploy a working alpha version. I am not so worried about performance in-game, as most of the actions will take place on the server side as pposed to the client side. I doubt latency will be an issue, as this game is turn-based.

If I wanted to make it fast, I could totally write it in pure Javascript. I like ActiveRecord too much, though.

The game itself is based upon a simple premise: You are either an adventurer or one of the bosses that stand in their way. Players will be organized in to a party of four with one boss (and the possibility of minions for specific boss builds) on the opposing side. Once the party wipes or the boss is dead, the match is over. Players will collect EXP and enchanted 'accessories' (or something) to power themselves up. Bosses will do the same or have a very similar system of character progression. 

## Players and Bosses

I decided to go with an extremely open-ended design pattern when it comes to actual playable entities. There is no standard class-based system like many traditional RPGs enforce. Instead, the stats of each character or boss is what determines the moveset that is available to them. However, this will be enforced by only having a certain number of move slots to work with (4 for characters, 6-8 for bosses) as well as a set number of skill points based on level and/or achievements. I plan to include passive effects in the form of equippable items and active efects in the form of abilities and skills. 

For example, the character Azorius has a stat spread of 5 strength, 2 agility, 1 intellect, and 4 faith. This character, in traditional RPG terms, may classify as a Paladin or Crusader class. With 5 strength, the character has access to powerful moves like Overhead Smash (5 str requirement) while also having access to Heal (3 faith requirement). However, having low intellect means that his acuity (magic defense, basically) will be low. Also, having 2 in Agility unlocks the passive ability 'dodge' which gives a small chance to completely avoid attacks. Much of these stats will directly influence how much damage players take and recieve as the game progresses. 

**The entire point of this system is to have me get out of the way and let others devise their own strategies.** It's a lot more fun that way. I am a HUGE fan of Dark Souls, and I feel like their model for character development is about as polished as it gets. It is a little harder to get in to initially, but once you understand the mechanics past basic speculation, it opens doors as far as creativity and balance go. If it takes off at all, I will personally write full documentation on the game itself to ease this process as much as possible. 

My goal is to find a spot where people can play to have fun, but not have to metagame their builds to climb ranks. I do realize the scope of this problem, but I have a few ideas about how to circumvent common issues. I will write up a blog post about it in the near future. I plan to write a lot of simulation tests to run random scenarios to find balance problems and things like that.

I don't plan on adding specific 'combo' effects, however. If you cast poison with a 3 turn duration twice in a row, it will compound the stacks and make the duration 6 (Well, technically 5 because a turn has to have passed before it is cast again unless something else happens to apply it before the second application has a chance to tick.)

## Combat

Combat is the entire reason that this game exists in the first place. I am planning on modeling it after a fairly traditional JRPG (think Final Fantasy) with multiplayer functionality. Not many games have tried to do this, mainly because it is so hard to come up with a fun system that doesn't rely on being 100% perfect. Leaving it open for people to interact how they please will either solve this problem or compound it. Time will tell. 

The game will play out as a turn-based RPG. Each entity will be sorted and put in to a turn order queue. Primarily because people hate waiting, all moves will be submitted at the same time (With a timer or some sort. You have to go before time runs out, or you auto-pass...) and the turn order will play out in explicit order based on the character's initiative score. Certain mechanics, like a Raison d'être (Which is essentially Overdrive/Last Stand), will interrupt the turn cycle. Certain moves like Swift Strike will always go first, but will have other drawbacks like not being able to critically hit or only having it deal a small amount of damage. 

I am also adding a true damage mechanic to some higher-level moves because, quite honestly, dumping all of your stats in to avoidance, going 100% hit-chance or heavy status-inducing moves, and neglecting to build health is simply unhealthy as far as combat design goes. An unhittable status-enducing terror of a character is simply not fun to playa against. My goal is to have a counter for everything even if it isn't perfectly apparent to newer players.

## Other Notes
__I am toying with the idea of having a level cap. These design decisions are hardly meant to be considered this early in the project and are more suited for a blog. I just need to get ideas down!__
