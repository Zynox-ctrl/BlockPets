<?php

declare(strict_types = 1);

namespace BlockHorizons\BlockPets\pets\creatures;

use BlockHorizons\BlockPets\pets\HoveringPet;
use BlockHorizons\BlockPets\pets\SmallCreature;

class ArrowPet extends HoveringPet implements SmallCreature {

	protected const PET_SAVE_ID = parent::PET_SAVE_ID . "arrow";
	protected const PET_NETWORK_ID = self::ARROW;

	public $name = "Arrow Pet";

	public $width = 0.5;
	public $height = 0.5;

	public function setCritical(bool $value = true): void {
		$this->setGenericFlag(self::DATA_FLAG_CRITICAL, $value);
	}
}
