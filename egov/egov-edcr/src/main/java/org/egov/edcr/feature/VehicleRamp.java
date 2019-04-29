/*
 * eGov  SmartCity eGovernance suite aims to improve the internal efficiency,transparency,
 * accountability and the service delivery of the government  organizations.
 *
 *  Copyright (C) <2019>  eGovernments Foundation
 *
 *  The updated version of eGov suite of products as by eGovernments Foundation
 *  is available at http://www.egovernments.org
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program. If not, see http://www.gnu.org/licenses/ or
 *  http://www.gnu.org/licenses/gpl.html .
 *
 *  In addition to the terms of the GPL license to be adhered to in using this
 *  program, the following additional terms are to be complied with:
 *
 *      1) All versions of this program, verbatim or modified must carry this
 *         Legal Notice.
 *      Further, all user interfaces, including but not limited to citizen facing interfaces,
 *         Urban Local Bodies interfaces, dashboards, mobile applications, of the program and any
 *         derived works should carry eGovernments Foundation logo on the top right corner.
 *
 *      For the logo, please refer http://egovernments.org/html/logo/egov_logo.png.
 *      For any further queries on attribution, including queries on brand guidelines,
 *         please contact contact@egovernments.org
 *
 *      2) Any misrepresentation of the origin of the material is prohibited. It
 *         is required that all modified versions of this material be marked in
 *         reasonable ways as different from the original version.
 *
 *      3) This license does not grant any rights to any user of the program
 *         with regards to rights under trademark law for use of the trade names
 *         or trademarks of eGovernments Foundation.
 *
 *  In case of any queries, you can reach eGovernments Foundation at contact@egovernments.org.
 */

package org.egov.edcr.feature;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.egov.common.entity.edcr.Block;
import org.egov.common.entity.edcr.Floor;
import org.egov.common.entity.edcr.Measurement;
import org.egov.common.entity.edcr.Plan;
import org.egov.common.entity.edcr.Result;
import org.egov.common.entity.edcr.ScrutinyDetail;
import org.egov.edcr.constants.DxfFileConstants;
import org.springframework.stereotype.Service;

@Service
public class VehicleRamp extends FeatureProcess {

	private static final String SUBRULE_40_8 = "40-8";
	private static final String DESCRIPTION = "Vehicle Ramp";
	private static final String FLOOR = "Floor";

	@Override
	public Plan validate(Plan pl) {
		for (Block block : pl.getBlocks()) {
			if (block.getBuilding() != null && !block.getBuilding().getFloors().isEmpty()) {
				for (Floor floor : block.getBuilding().getFloors()) {
					List<org.egov.common.entity.edcr.VehicleRamp> vehicleRamps = floor.getVehicleRamps();
					if (vehicleRamps != null && !vehicleRamps.isEmpty()) {
						for (org.egov.common.entity.edcr.VehicleRamp vehicleRamp : vehicleRamps) {
							List<Measurement> vehicleRampPolyLines = vehicleRamp.getRampPolyLines();
							if (vehicleRampPolyLines != null && !vehicleRampPolyLines.isEmpty()) {
								validateDimensions(pl, block.getNumber(), floor.getNumber(),
										vehicleRamp.getNumber().toString(), vehicleRampPolyLines);
							}
						}
					}
				}
			}
		}
		return pl;
	}

	@Override
	public Plan process(Plan pl) {
		validate(pl);
		BigDecimal coverParkingArea = BigDecimal.ZERO;
		BigDecimal basementParkingArea = BigDecimal.ZERO;
		for (Block block : pl.getBlocks()) {
			for (Floor floor : block.getBuilding().getFloors()) {
				coverParkingArea = coverParkingArea.add(floor.getParking().getCoverCars().stream()
						.map(Measurement::getArea).reduce(BigDecimal.ZERO, BigDecimal::add));
				basementParkingArea = basementParkingArea.add(floor.getParking().getBasementCars().stream()
						.map(Measurement::getArea).reduce(BigDecimal.ZERO, BigDecimal::add));
			}
		}
		HashMap<String, String> errors = new HashMap<>();
		BigDecimal totalProvidedCarParkArea = coverParkingArea.add(basementParkingArea);
		BigDecimal vehicleRampTotalLength, vehicleRampSlope, minWidth = BigDecimal.ZERO;
		List<BigDecimal> vehicleRampLengths = new ArrayList<>();
		boolean valid, valid1, valid2;
		Map<String, String> details = new HashMap<>();
		details.put(RULE_NO, SUBRULE_40_8);
		details.put(DESCRIPTION, DESCRIPTION);
		if (totalProvidedCarParkArea != null && totalProvidedCarParkArea.compareTo(BigDecimal.ZERO) > 0) {
			if (pl != null && !pl.getBlocks().isEmpty()) {
				for (Block block : pl.getBlocks()) {
					scrutinyDetail = new ScrutinyDetail();
					scrutinyDetail.addColumnHeading(1, RULE_NO);
					scrutinyDetail.addColumnHeading(2, DESCRIPTION);
					scrutinyDetail.addColumnHeading(3, FLOOR);
					scrutinyDetail.addColumnHeading(4, REQUIRED);
					scrutinyDetail.addColumnHeading(5, PROVIDED);
					scrutinyDetail.addColumnHeading(6, STATUS);
					scrutinyDetail.setKey("Vehicle Ramp");

					if (block.getBuilding() != null && !block.getBuilding().getOccupancies().isEmpty()) {
						if (block.getBuilding() != null && !block.getBuilding().getFloors().isEmpty()) {
							for (Floor floor : block.getBuilding().getFloors()) {
								for (org.egov.common.entity.edcr.VehicleRamp vehicleRamp : floor.getVehicleRamps()) {
									if (vehicleRamp.getRampPolyLineClosed()) {
										vehicleRampLengths = new ArrayList<>();
										for (Measurement measurement : vehicleRamp.getRampPolyLines()) {
											vehicleRampLengths.add(measurement.getHeight());
										}
										vehicleRampTotalLength = BigDecimal.ZERO;
										for (BigDecimal length : vehicleRampLengths) {
											vehicleRampTotalLength = vehicleRampTotalLength.add(length);
										}
										if (vehicleRampTotalLength.compareTo(BigDecimal.valueOf(0)) > 0
												&& vehicleRamp.getFloorHeight() != null) {
											vehicleRampSlope = vehicleRamp.getFloorHeight()
													.divide(vehicleRampTotalLength, 2, RoundingMode.HALF_UP);
											vehicleRamp.setSlope(vehicleRampSlope);
										}
									}
								}

								if (floor.getNumber() != 0) {
									if ((floor.getParking() != null && floor.getParking().getMechanicalLifts() != null
											&& !floor.getParking().getMechanicalLifts().isEmpty())
											|| (floor.getVehicleRamps() != null
													&& !floor.getVehicleRamps().isEmpty())) {

										if (floor.getParking().getMechanicalLifts() == null
												|| floor.getParking().getMechanicalLifts().isEmpty()) {
											valid = false;
											valid1 = false;
											valid2 = false;
											for (org.egov.common.entity.edcr.VehicleRamp vehicleRamp : floor
													.getVehicleRamps()) {
												minWidth = BigDecimal.ZERO;
												for (Measurement polyLine : vehicleRamp.getRampPolyLines()) {
													if (polyLine.getWidth().compareTo(minWidth) < 0) {
														minWidth = polyLine.getWidth();
													}
												}

												if (minWidth.compareTo(new BigDecimal(5.4)) >= 0
														&& vehicleRamp.getSlope() != null && vehicleRamp.getSlope()
																.compareTo(new BigDecimal(0.12)) <= 0) {
													valid = true;
												}

												if (valid1 && minWidth.compareTo(new BigDecimal(3.6)) >= 0
														&& vehicleRamp.getSlope() != null && vehicleRamp.getSlope()
																.compareTo(new BigDecimal(0.12)) <= 0) {
													valid2 = true;
												}

												if (!valid1 && minWidth.compareTo(new BigDecimal(3.6)) >= 0
														&& vehicleRamp.getSlope() != null && vehicleRamp.getSlope()
																.compareTo(new BigDecimal(0.12)) <= 0) {
													valid1 = true;
												}

											}

											if (valid || (valid1 && valid2)) {
												details.put(FLOOR, "Floor " + floor.getNumber());
												details.put(REQUIRED,
														"At least two vehicle ramps of minimum 3.6 m width or one vehicle ramp of minimum 5.4 m width and in maximum 1:8 slope");
												details.put(PROVIDED,
														valid ? "Provided vehicle ramp with minimum 5.4 width"
																: "Provided two vehicle ramps of minimum 3.6 m width");
												details.put(STATUS, Result.Accepted.getResultVal());
												scrutinyDetail.getDetail().add(details);
												pl.getReportOutput().getScrutinyDetails().add(scrutinyDetail);
											} else {
												details.put(FLOOR, "Floor " + floor.getNumber());
												details.put(REQUIRED,
														"At least two vehicle ramps of minimum 3.6 m width or one vehicle ramp of minimum 5.4 m width and in maximum 1:8 slope");
												details.put(PROVIDED,
														"Not Provided vehicle ramp with minimum 5.4 width or  two vehicle ramps of minimum 3.6 m width");
												details.put(STATUS, Result.Not_Accepted.getResultVal());
												scrutinyDetail.getDetail().add(details);
												pl.getReportOutput().getScrutinyDetails().add(scrutinyDetail);
											}

										}

									} else {
										errors.put("Vehicle Ramp", "Either ramp or mechanical lift is required");
										pl.addErrors(errors);

									}
								}
							}
						}

					}
				}
			}
		}

		return pl;
	}

	private void validateDimensions(Plan planDetail, String blockNo, int floorNo, String rampNo,
			List<Measurement> rampPolylines) {
		int count = 0;
		for (Measurement m : rampPolylines) {
			if (m.getInvalidReason() != null && m.getInvalidReason().length() > 0) {
				count++;
			}
		}
		if (count > 0) {
			planDetail.addError(String.format(DxfFileConstants.LAYER_VEHICLE_RAMP_WITH_NO, blockNo, floorNo, rampNo),
					count + " number of vehicle ramp polyline not having only 4 points in layer "
							+ String.format(DxfFileConstants.LAYER_VEHICLE_RAMP_WITH_NO, blockNo, floorNo, rampNo));

		}
	}

	@Override
	public Map<String, Date> getAmendments() {
		return new LinkedHashMap<>();
	}
}
