#include "Effects/Game/AutoPlantC4.sp"
#include "Effects/Game/BlackWhite.sp"
#include "Effects/Game/BreakTime.sp"
#include "Effects/Game/BuyAnywhere.sp"
#include "Effects/Game/C4Chicken.sp"
#include "Effects/Game/DisableRadar.sp"
#include "Effects/Game/Earthquake.sp"
#include "Effects/Game/EnemyRadar.sp"
#include "Effects/Game/ExtremeWhiteFog.sp"
#include "Effects/Game/FakeCrash.sp"
#include "Effects/Game/FakeLag.sp"
#include "Effects/Game/IsThisMexico.sp"
#include "Effects/Game/LSD.sp"
#include "Effects/Game/LightsOff.sp"
#include "Effects/Game/LittleChooks.sp"
#include "Effects/Game/LowRenderDistance.sp"
#include "Effects/Game/PigeonHole.sp"
#include "Effects/Game/RandomSkybox.sp"
#include "Effects/Game/RevealEnemyLocation.sp"
#include "Effects/Game/Saturation.sp"
#include "Effects/Game/Snow.sp"
#include "Effects/Game/Spawnables/BigChooks.sp"
#include "Effects/Game/Spawnables/MamaChook.sp"
#include "Effects/Game/Spawnables/MoneyRain.sp"
#include "Effects/Game/Spawnables/RainingMolotovs.sp"
#include "Effects/Game/Spawnables/SmokeStrat.sp"
#include "Effects/Game/Spawnables/Soccerballs.sp"
#include "Effects/Game/Spawnables/SpawnExplodingBarrels.sp"
#include "Effects/Game/Spawnables/SpawnFlashbangs.sp"
#include "Effects/Game/Thunderstorm.sp"

#include "Effects/Meta/DoubleTimerSpeed.sp"
#include "Effects/Meta/HalfTimerSpeed.sp"
#include "Effects/Meta/MegaChaos.sp"
#include "Effects/Meta/WhatsHappening.sp"

#include "Effects/Player/Aimbot.sp"
#include "Effects/Player/AlienModelKnife.sp"
#include "Effects/Player/Autobhop.sp"
#include "Effects/Player/Bankrupt.sp"
#include "Effects/Player/Binoculars.sp"
#include "Effects/Player/BlindPlayers.sp"
#include "Effects/Player/Bumpmines.sp"
#include "Effects/Player/ChickenPlayers.sp"
#include "Effects/Player/CrabPeople.sp"
#include "Effects/Player/DecoyDodgeball.sp"
#include "Effects/Player/DisableForwardBack.sp"
#include "Effects/Player/DisableStrafe.sp"
#include "Effects/Player/DiscoFog.sp"
#include "Effects/Player/DiscoPlayers.sp"
#include "Effects/Player/DoubleJump.sp"
#include "Effects/Player/DropCurrentWeapon.sp"
#include "Effects/Player/DropPrimaryWeapon.sp"
#include "Effects/Player/Drugs.sp"
#include "Effects/Player/ESP.sp"
#include "Effects/Player/ExplosiveBullets.sp"
#include "Effects/Player/ExtendedGrenades.sp"
#include "Effects/Player/FakeTeleport.sp"
#include "Effects/Player/FastSpeed.sp"
#include "Effects/Player/Flying.sp"
#include "Effects/Player/ForceReload.sp"
#include "Effects/Player/GhostSlaps.sp"
#include "Effects/Player/Give100HP.sp"
#include "Effects/Player/HeadshotOnly.sp"
#include "Effects/Player/HealAllPlayers.sp"
#include "Effects/Player/HealthRegen.sp"
#include "Effects/Player/Healthshot.sp"
#include "Effects/Player/IceSkate.sp"
#include "Effects/Player/IceyGround.sp"
#include "Effects/Player/IgniteAllPlayers.sp"
#include "Effects/Player/Impostors.sp"
#include "Effects/Player/IncreasedRecoil.sp"
#include "Effects/Player/InfiniteAmmo.sp"
#include "Effects/Player/InfiniteGrenades.sp"
#include "Effects/Player/InsaneAirSpeed.sp"
#include "Effects/Player/InsaneGravity.sp"
#include "Effects/Player/Invis.sp"
#include "Effects/Player/Jackpot.sp"
#include "Effects/Player/Juggernaut.sp"
#include "Effects/Player/Jumping.sp"
#include "Effects/Player/KnifeFight.sp"
#include "Effects/Player/LavaFloor.sp"
#include "Effects/Player/LockPlayersAim.sp"
#include "Effects/Player/LooseTrigger.sp"
#include "Effects/Player/MoonGravity.sp"
#include "Effects/Player/NightVision.sp"
#include "Effects/Player/NoCrosshair.sp"
#include "Effects/Player/NoScopeOnly.sp"
#include "Effects/Player/NoSpread.sp"
#include "Effects/Player/NormalWhiteFog.sp"
#include "Effects/Player/Nothing.sp"
#include "Effects/Player/OHKO.sp"
#include "Effects/Player/OneBulletMag.sp"
#include "Effects/Player/OneBulletOneGun.sp"
#include "Effects/Player/OneWeaponOnly.sp"
#include "Effects/Player/PortalGuns.sp"
#include "Effects/Player/QuakeFOV.sp"
#include "Effects/Player/RandomInvisiblePlayer.sp"
#include "Effects/Player/RandomTeleport.sp"
#include "Effects/Player/RandomWeapons.sp"
#include "Effects/Player/RapidFire.sp"
#include "Effects/Player/ReducedDamage.sp"
#include "Effects/Player/ResetSpawns.sp"
#include "Effects/Player/RespawnDead_LastLocation.sp"
#include "Effects/Player/RespawnTheDead.sp"
#include "Effects/Player/RespawnTheDead_Randomly.sp"
#include "Effects/Player/ReversedMovement.sp"
#include "Effects/Player/ReversedRecoil.sp"
#include "Effects/Player/ReversedStrafe.sp"
#include "Effects/Player/RewindTenSeconds.sp"
#include "Effects/Player/Shields.sp"
#include "Effects/Player/SilentFootsteps.sp"
#include "Effects/Player/SimonSays.sp"
#include "Effects/Player/SlayRandomPlayer.sp"
#include "Effects/Player/SlowSpeed.sp"
#include "Effects/Player/SneakyBeaky.sp"
#include "Effects/Player/SpeedShooter.sp"
#include "Effects/Player/Spin180.sp"
#include "Effects/Player/SuperJump.sp"
#include "Effects/Player/TaserParty.sp"
#include "Effects/Player/TeammateSwap.sp"
#include "Effects/Player/TeleportFewMetres.sp"
#include "Effects/Player/Thirdperson.sp"
#include "Effects/Player/VampireHeal.sp"
#include "Effects/Player/WKeyStuck.sp"