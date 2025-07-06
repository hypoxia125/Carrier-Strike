#include "script_component.hpp"

player removeDiarySubject "Diary";
player removeDiarySubject "Units";
player removeDiarySubject "Statistics";

private _indent = "  ";
private _bullet = "-  ";
private _endl = "<br/>";

// -------------
// How to Play
// -------------
player createDiarySubject ["HowToPlay", "How To Play"];

private _title = "<font size='24' face='PuristaBold'>Carrier Strike</font>" + _endl + "By: Hypoxic";

private _briefing_1 = "<font size='16' face='PuristaBold'>Destroy The Enemy Carrier</font>" + _endl + _indent +_bullet + "Each team has a Carrier." + _endl + _indent + _bullet + "The main objective is to destroy the enemy's carrier while protecting your own." + _endl + _indent + _bullet + "Carriers are initially defended by an invulnerable dome of CWIS weapon systems. The defenses will shut down after the Carrier takes 50% damage";

private _briefing_2 = "<font size='16' face='PuristaBold'>Bringing Down The Carrier</font>" + _endl + _indent + _bullet + "To bring down the enemy Carrier, players must capture and hold Missile Silos scattered across the map." + _endl + _indent + _bullet + "These silos launch missiles at regular intervals targetting the enemy Carrier." + _endl + _indent + _bullet + "The more silos a team controls, the faster the enemy Carrier HP will deplete.";

private _briefing_3 = "<font size='16' face='PuristaBold'>Boarding The Enemy Carrier</font>" + _endl + _indent + _bullet + "Once the Carrier defenses are down, players can board the enemy Carrier." + _endl + _indent + _bullet + "Players can board the enemy Carrier by landing transport choppers, ejecting and landing via parachute, or by climbing the ladder system on the rear of the Carrier.";

private _briefing_4 = "<font size='16' face='PuristaBold'>Destroying The Enemy Carrier's Reactors</font>" + _endl + _indent + _bullet + "After boarding, players must navigate across the Carrier to reach the reactors." + _endl + _indent + _bullet + "There are four reactors that can be destroyed." + _endl + _indent + _bullet + "With each reactor that is destroyed, the enemy Carrier will lose 12.5% HP (25% of a half health Carrier).";

private _array = [];
{
    if (_forEachIndex == (count _array - 1)) then {
        _array = _array + [_x];
    } else {
        _array = _array + [_endl, _endl, _x];
    };
} forEachReversed [_title, _briefing_1, _briefing_2, _briefing_3, _briefing_4];
reverse _array;

private _string = _array joinString "";
player createDiaryRecord [
    "HowToPlay",
    ["How To Play", _string],
    taskNull,
    "NONE",
    false
];
