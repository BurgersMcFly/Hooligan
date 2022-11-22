// Hooligan, Cyberpunk 2077 mod that makes vandalizing Vending Machines and Drop Points possible, interesting and profitable
// Copyright (C) 2022 BurgersMcFly

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

@replaceMethod(DropPoint)
protected cb func OnHitEvent(hit: ref<gameHitEvent>, soldOut: Bool) -> Bool {
    let quantity: Int32;
    let TS: ref<TransactionSystem>;
    if this.GetBlackboard().GetBool(GetAllBlackboardDefs().VendingMachineDeviceBlackboard.SoldOut) {
        this.StartShortGlitch();
        return false;
    }

    if RandRangeF(0.0, 10.0) <= 5.0  {
        quantity = RandRange(1, 500);
        TS = GameInstance.GetTransactionSystem(this.GetGame());
        TS.GiveItem(GetPlayer(this.GetGame()), MarketSystem.Money(), quantity);
    }

    else {
        if RandRangeF(0.0, 10.0) <= 4.0  {
            quantity = RandRange(1, 250);
            TS = GameInstance.GetTransactionSystem(this.GetGame());
            TS.GiveItem(GetPlayer(this.GetGame()), MarketSystem.Money(), quantity);
        }
        else {
            if RandRangeF(0.0, 10.0) <= 3.0  {
                quantity = RandRange(1, 125);
                TS = GameInstance.GetTransactionSystem(this.GetGame());
                TS.GiveItem(GetPlayer(this.GetGame()), MarketSystem.Money(), quantity);
            }
            else {
                if RandRangeF(0.0, 10.0) <= 2.0  {
                    quantity = RandRange(1, 75);
                    TS = GameInstance.GetTransactionSystem(this.GetGame());
                    TS.GiveItem(GetPlayer(this.GetGame()), MarketSystem.Money(), quantity);
                }
                else {
                    if RandRangeF(0.0, 10.0) > 5.0 {
                        this.GetBlackboard().SetBool(GetAllBlackboardDefs().VendingMachineDeviceBlackboard.SoldOut, soldOut);
                        this.TurnOffDevice();
                    }
                }
            }
        }
    }

    super.OnHitEvent(hit);
    this.StartShortGlitch();
}
