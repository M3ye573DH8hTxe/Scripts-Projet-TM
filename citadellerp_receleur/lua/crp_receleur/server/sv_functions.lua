function CitadelleRP.Receleur:SellCar(pnj, ply)

	local VehicleSphereReceleur = ents.FindInSphere(pnj:GetPos(), 70)

	if #VehicleSphereReceleur >= 1 then

		for k, ent in pairs(VehicleSphereReceleur) do

			if ent:GetClass() == "prop_vehicle_jeep" then

					if ent:getDoorOwner() == ply then

						DarkRP.notify(ply, 1, 4, "Désolé man, c'est ton véhicule. J'achète pas...")

					elseif ent:getDoorOwner() == nil then
										
						DarkRP.notify(ply, 1, 4, "Désolé man, je connais la personne qui a ce véhicule.")

					else
									
						local generatemoneydealer = math.random( 0.8, 1.3)
						local priceVehicle = 4000
						local finalPrice = generatemoneydealer * priceVehicle

						ent:Remove()

						DarkRP.notify(ply, 0, 4, "Affaire conclue ! Je vais la faire quitter la ville. Tiens l'argent et par terre à mes pieds , " .. finalPrice .. "$")
						DarkRP.createMoneyBag(pnj:GetPos() + Vector(30, 0, 40), finalPrice)
					end

			else

				-- [ DarkRP.notify(ply, 1, 4, "Désolé man, c'est pas un véhicule ça.")
				-- [ break

			end

		end

	else

		DarkRP.notify(ply, 1, 4, "Hé man, je vois aucune voiture. Reviens me voir avec une caisse.")

	end

end
