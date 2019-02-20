-- #!mysql
-- #{ blockpets

-- #  { init
CREATE TABLE IF NOT EXISTS Pets(
  Player VARCHAR(16) NOT NULL,
  PetName VARCHAR(48) NOT NULL,
  EntityName VARCHAR(32) NOT NULL,
  PetSize FLOAT NOT NULL DEFAULT 1.0,
  IsBaby BOOL NOT NULL DEFAULT false,
  Chested BOOL NOT NULL DEFAULT false,
  Visible BOOL NOT NULL DEFAULT true,
  PetLevel INT UNSIGNED NOT NULL DEFAULT 1,
  LevelPoints INT UNSIGNED NOT NULL DEFAULT 0,
  Inventory BLOB,
  PRIMARY KEY(Player, PetName)
);
-- #  }

-- #  { loadplayer
-- #    :player string
SELECT
  PetName,
  EntityName,
  PetSize,
  IsBaby,
  Chested,
  PetLevel,
  LevelPoints,
  Visible,
  Inventory
FROM Pets WHERE Player=:player;
-- #  }

-- #  { listpets
-- #    :player string
-- #    :entityname string
SELECT
  PetName,
  EntityName,
  Visible
FROM Pets WHERE Player=:player AND EntityName LIKE :entityname;
-- #  }

-- #  { reset
DELETE FROM Pets;
-- #  }

-- #  { pet

-- #    { register
-- #      :player string
-- #      :petname string
-- #      :entityname string
-- #      :petsize float
-- #      :isbaby int
-- #      :chested int
-- #      :petlevel int
-- #      :levelpoints int
-- #      :visible int
-- #      :inventory string
INSERT INTO Pets(
  Player,
  PetName,
  EntityName,
  PetSize,
  IsBaby,
  Chested,
  PetLevel,
  LevelPoints,
  Visible,
  Inventory
) VALUES (
  :player,
  :petname,
  :entityname,
  :petsize,
  :isbaby,
  :chested,
  :petlevel,
  :levelpoints,
  :visible,
  :inventory
) ON DUPLICATE KEY UPDATE
PetName=VALUES(PetName),
EntityName=VALUES(EntityName),
PetSize=VALUES(PetSize),
IsBaby=VALUES(IsBaby),
Chested=VALUES(Chested),
PetLevel=VALUES(PetLevel),
LevelPoints=VALUES(LevelPoints),
Visible=VALUES(Visible),
Inventory=VALUES(Inventory);
-- #    }

-- #    { unregister
-- #      :player string
-- #      :petname string
DELETE FROM Pets
WHERE Player=:player AND petname=:petname;
-- #    }

-- #    { leaderboard
-- #      :offset int
-- #      :length int
-- #      :entityname string
SELECT
  Player,
  PetName,
  EntityName,
  PetLevel,
  LevelPoints
FROM Pets WHERE EntityName LIKE :entityname ORDER BY LevelPoints, PetLevel DESC LIMIT :offset, :length;
-- #    }

-- #    { visibility
-- #      { toggle
-- #        :player string
-- #        :petname string
UPDATE Pets SET Visible=NOT Visible
WHERE Player=:player AND PetName LIKE :petname;
-- #      }
-- #      { select
-- #        :player string
-- #        :petname string
SELECT PetName, Visible FROM Pets
WHERE Player=:player AND PetName LIKE :petname;
-- #      }
-- #    }
-- #  }

-- #}
