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

@replaceMethod(VendingMachine)
protected cb func OnHitEvent(hit: ref<gameHitEvent>, this: wref<IWorldWidgetComponent>) -> Bool {
    let quantity: Int32;
    let index: Int32;
    let junkItem: ItemID;
    let junkPool: array<JunkItemRecord>;
    let TS: ref<TransactionSystem>;
    let evt: ref<VendingMachineFinishedEvent>;
    if this.GetBlackboard().GetBool(GetAllBlackboardDefs().VendingMachineDeviceBlackboard.SoldOut) {
        this.StartShortGlitch();
        return false;
    }

    if RandRangeF(0.0, 10.0) > 7.5 {
        this.SendSoldOutToUIBlackboard(true);
        this.TurnOffDevice();
        if RandRangeF(0.0, 10.0) <= 2.5 {
            this.DispenseItems(this.CreateDispenseRequest(false, evt.itemID));
            if RandRangeF(0.0, 10.0) <= 1.5 {
                this.DelayVendingMachineEvent(0.20, true, true);
            }
            this.PlayItemFall();
            this.RefreshUI();
        }
        else {
            if RandRangeF(0.0, 10.0) > 2.5 && RandRangeF(0.0, 10.0) <= 5.0 {
                TS = GameInstance.GetTransactionSystem(this.GetGame());
                junkPool = this.m_vendorID.GetJunkItemIDs();
                junkItem = ItemID.FromTDBID(junkPool[index].m_junkItemID);
                TS.GiveItem(this, junkItem, 1);
                this.DelayHackedEvent(0, junkItem);
            }
            else {
                if RandRangeF(0.0, 10.0) > 5.0 && RandRangeF(0.0, 10.0) <= 7.5 {
                    quantity = RandRange(1, 25);
                    TS = GameInstance.GetTransactionSystem(this.GetGame());
                    TS.GiveItem(GetPlayer(this.GetGame()), MarketSystem.Money(), quantity);
                }
            }
        }
    }

    super.OnHitEvent(hit);
    this.StartShortGlitch();
}
