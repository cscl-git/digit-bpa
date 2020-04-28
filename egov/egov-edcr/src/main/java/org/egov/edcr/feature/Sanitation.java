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
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

import org.apache.log4j.Logger;
import org.egov.common.entity.dcr.helper.OccupancyHelperDetail;
import org.egov.common.entity.edcr.Block;
import org.egov.common.entity.edcr.Floor;
import org.egov.common.entity.edcr.Measurement;
import org.egov.common.entity.edcr.Occupancy;
import org.egov.common.entity.edcr.OccupancyTypeHelper;
import org.egov.common.entity.edcr.Plan;
import org.egov.common.entity.edcr.Result;
import org.egov.common.entity.edcr.SanityDetails;
import org.egov.common.entity.edcr.SanityHelper;
import org.egov.common.entity.edcr.ScrutinyDetail;
import org.egov.edcr.constants.DxfFileConstants;
import org.egov.edcr.service.cdg.CDGAConstant;
import org.egov.edcr.service.cdg.CDGAdditionalService;
import org.egov.edcr.utility.DcrConstants;
import org.springframework.stereotype.Service;

/**
 * @author mani
 */

@Service
public class Sanitation extends FeatureProcess {
	public static final String MSG_ERROR_MANDATORY = "msg.error.mandatory.object.not.defined";
	public static final String FEMALE = "Female ";
	public static final String MALE = "Male ";
	public static final String BLOCK = "Block ";
	public static final String SANITY_RULE_DESC = "Sanity facility for Occupancy ";
	public static final String NEWLINE = "\n";
	public static final String SANITATION = "Sanitation";
	public static final String BLOCK_U_S = "Block_";
	private static final String WITH = " with ";
	private static final String BLDG_PART_WATER_CLOSET = "Water Closet";
	private static final String BLDG_PART_SPECIAL_WATER_CLOSET = "Special Water Closet";
	private static final String BLDG_PART_URINAL = "Urinal";
	private static final String BLDG_DRINKING_WATER = "Driniking Water";
	private static final String BLDG_PART_BATHROOM = "Bath Room";
	private static final String MALE_BATH_WITH_WC = BLDG_PART_BATHROOM + WITH + BLDG_PART_WATER_CLOSET;
	private static final String BLDG_PART_WASHBASIN = "Wash Basin";
	private static final String MINIMUM_SIDE_DIMENSION_VIOLATED = "Minimum Side Dimension of {0} M violated";
	private static final String MINIMUM_AREA_DIMENSION_VIOLATED = "Minimum Area of {0} M violated";
	private static final String DIMESION_DESC_KEY = "msg.sanity.dimension.desc";
	/*
	 * private static final String DIMESION_DESC_BATH =
	 * "The area of bath-room shall not be less than 1.50 sq.m. with either side not less than 1.1m"
	 * ; private static final String DIMESION_DESC_BATH_WC =
	 * "The area of combined bathroom and latrine shall be not less than 2.2 square "
	 * + "metres with one side not less than 1. 1 metres";
	 */
	private static final Logger LOG = Logger.getLogger(Sanitation.class);
	/*
	 * private static final String RULE_NAME_KEY = "sanitation.rulename"; private
	 * static final String RULE_DESCRIPTION_KEY = "sanitation.description"; private
	 * static final String RULE_EXPECTED_KEY = "sanitation.expected"; private static
	 * final String RULE_ACTUAL_KEY = "sanitation.actual";
	 */
	private static final String FEATURE_NAME = "Sanitary Detail";
	/*
	 * private static final String SIDE = "SIDE"; private static final String AREA =
	 * "AREA";
	 */
	private static final String RULE_38_1 = "38-1";
	private static final String NOOFBEDS = "No Of Beds";
	public static final String RULE_55_12 = "55-12";
	public static final String RULE_40_A_4 = "40A-4";
	public static final String RULE_54_6 = "54-6";
	public static final BigDecimal MINAREAOFSPWC = BigDecimal.valueOf(2.625);
	public static final BigDecimal MINDIMENSIONOFSPWC = BigDecimal.valueOf(1.5);
	public static final String MINIMUM_AREA_SPWC = "2.625" + DxfFileConstants.METER_SQM;
	public static final String MINIMUM_DIMENSION_SPWC = "1.5" + DxfFileConstants.METER;

	@Override
	public Plan validate(Plan pl) {

		for (Block b : pl.getBlocks()) {
			if (!b.getCompletelyExisting()) {

				int totalSpecialWC = 0;
				int totalWashBasins = 0;
				for (Floor f : b.getBuilding().getFloors()) {
					totalSpecialWC += f.getSpecialWaterClosets().size();
					totalWashBasins += f.getWashBasins().size();
				}
				b.getSanityDetails().setTotalSPWC(totalSpecialWC);
				b.getSanityDetails().setTotalwashBasins(totalWashBasins);

				/*
				 * If block is small plot and floors above ground less than or equal to three
				 * and occupancy type of entire block is either Residential or Commercial then
				 * sanitation validation not require.
				 */
				List<Occupancy> occupancies = b.getBuilding().getTotalArea();
				SanityDetails sanityDetails = b.getSanityDetails();
				validateDimensions(pl, b, sanityDetails);
				for (Occupancy occupancy : occupancies) {
					OccupancyHelperDetail o = occupancy.getTypeHelper().getSubtype() != null
							? occupancy.getTypeHelper().getSubtype()
							: occupancy.getTypeHelper().getType();
					switch (o.getCode()) {
					case DxfFileConstants.A:
					case DxfFileConstants.A_SR:
					case DxfFileConstants.A_AF:
						if (sanityDetails.getTotalSPWC() == 0)
							pl.addError(BLDG_PART_SPECIAL_WATER_CLOSET, getLocaleMessage(MSG_ERROR_MANDATORY,
									FEATURE_NAME, BLDG_PART_SPECIAL_WATER_CLOSET, b.getNumber()));
						break;
					case DxfFileConstants.A_HE:
						commonSanitationValidations(pl, b, sanityDetails, o);
						validateBathRoom(pl, b, sanityDetails);
						break;
					case DxfFileConstants.B:
					case DxfFileConstants.B2:
					case DxfFileConstants.B_HEI:
						commonSanitationValidations(pl, b, sanityDetails, o);
						break;
					case DxfFileConstants.C_MIP:
						commonSanitationValidations(pl, b, sanityDetails, o);
						if (pl.getPlanInformation().getNoOfBeds() == null)
							pl.addError(NOOFBEDS,
									getLocaleMessage(MSG_ERROR_MANDATORY, FEATURE_NAME, NOOFBEDS, b.getNumber()));
						break;
					case DxfFileConstants.C_MOP:
					case DxfFileConstants.C_MA:
						commonSanitationValidations(pl, b, sanityDetails, o);
						break;
					case DxfFileConstants.D:
					case DxfFileConstants.D_AW:
					case DxfFileConstants.D_BT:
						commonSanitationValidations(pl, b, sanityDetails, o);
						break;
					case DxfFileConstants.E:
					case DxfFileConstants.F:
					case DxfFileConstants.F_K:
						commonSanitationValidations(pl, b, sanityDetails, o);
						break;
					case DxfFileConstants.F_H:
						commonSanitationValidations(pl, b, sanityDetails, o);
						validateBathRoom(pl, b, sanityDetails);
						break;
					case DxfFileConstants.G:
					case DxfFileConstants.G_SI:
					case DxfFileConstants.H:
					case DxfFileConstants.I1:
					case DxfFileConstants.I2:
						if (sanityDetails.getMaleWaterClosets().isEmpty()
								&& sanityDetails.getFemaleWaterClosets().isEmpty()) {
							pl.addError(BLDG_PART_WATER_CLOSET, getLocaleMessage(MSG_ERROR_MANDATORY, FEATURE_NAME,
									BLDG_PART_WATER_CLOSET, b.getNumber()));
						}

						if (sanityDetails.getUrinals().isEmpty()) {
							pl.addError(BLDG_PART_URINAL, getLocaleMessage(MSG_ERROR_MANDATORY, FEATURE_NAME,
									BLDG_PART_URINAL, b.getNumber()));
						}
						break;
					}
				}
			}
		}
		return pl;
	}

	private void validateBathRoom(Plan pl, Block b, SanityDetails sanityDetails) {
		if (sanityDetails.getMaleBathRooms().isEmpty() && sanityDetails.getFemaleBathRooms().isEmpty()
				&& sanityDetails.getMaleRoomsWithWaterCloset().isEmpty()
				&& sanityDetails.getFemaleRoomsWithWaterCloset().isEmpty()) {
			pl.addError(BLDG_PART_BATHROOM,
					getLocaleMessage(MSG_ERROR_MANDATORY, FEATURE_NAME, BLDG_PART_BATHROOM, b.getNumber()));
		}
	}

	private void commonSanitationValidations(Plan pl, Block b, SanityDetails sanityDetails,
			OccupancyHelperDetail type) {
		if (sanityDetails.getMaleWaterClosets().isEmpty() && sanityDetails.getFemaleWaterClosets().isEmpty()
				&& sanityDetails.getMaleRoomsWithWaterCloset().isEmpty()
				&& sanityDetails.getFemaleRoomsWithWaterCloset().isEmpty()) {
			pl.addError(BLDG_PART_WATER_CLOSET,
					getLocaleMessage(MSG_ERROR_MANDATORY, FEATURE_NAME, BLDG_PART_WATER_CLOSET, b.getNumber()));
		}

		if (sanityDetails.getUrinals().isEmpty()) {
			pl.addError(BLDG_PART_URINAL,
					getLocaleMessage(MSG_ERROR_MANDATORY, FEATURE_NAME, BLDG_PART_URINAL, b.getNumber()));
		}

		if (!DxfFileConstants.F.equals(type.getCode()) && !DxfFileConstants.F_K.equals(type.getCode())
				&& !DxfFileConstants.E.equals(type.getCode()) && sanityDetails.getTotalwashBasins() == 0) {
			pl.addError(BLDG_PART_WASHBASIN,
					getLocaleMessage(MSG_ERROR_MANDATORY, FEATURE_NAME, BLDG_PART_WASHBASIN, b.getNumber()));
		}

		if (sanityDetails.getTotalSPWC() == 0)
			pl.addError(BLDG_PART_SPECIAL_WATER_CLOSET,
					getLocaleMessage(MSG_ERROR_MANDATORY, FEATURE_NAME, BLDG_PART_SPECIAL_WATER_CLOSET, b.getNumber()));

	}

	private void validateDimensions(Plan pl, Block b, SanityDetails sanityDetails) {
		if (!sanityDetails.getUrinals().isEmpty()) {
			int count = 0;
			for (Measurement m : sanityDetails.getUrinals()) {
				if (m.getInvalidReason() != null && m.getInvalidReason().length() > 0) {
					count++;
				}
			}
			if (count > 0) {
				pl.addError("Sanity_" + BLDG_PART_URINAL + b.getNumber(), count + " number of " + BLDG_PART_URINAL
						+ " polyline not having only 4 points in block" + b.getNumber());

			}
		}
		List<Measurement> wcList = new ArrayList<>();
		wcList.addAll(sanityDetails.getMaleWaterClosets());
		wcList.addAll(sanityDetails.getFemaleWaterClosets());
		wcList.addAll(sanityDetails.getCommonWaterClosets());
		if (!wcList.isEmpty()) {
			int count = 0;
			for (Measurement m : wcList) {
				if (m.getInvalidReason() != null && m.getInvalidReason().length() > 0) {
					count++;
				}
			}
			if (count > 0) {
				pl.addError("Sanity_" + BLDG_PART_WATER_CLOSET + b.getNumber(), count + " number of "
						+ BLDG_PART_WATER_CLOSET + " polyline not having only 4 points in block" + b.getNumber());

			}
		}

		List<Measurement> bath = new ArrayList<>();
		bath.addAll(sanityDetails.getMaleBathRooms());
		bath.addAll(sanityDetails.getFemaleBathRooms());
		bath.addAll(sanityDetails.getCommonBathRooms());

		List<Measurement> wcrList = new ArrayList<>();
		wcrList.addAll(sanityDetails.getMaleRoomsWithWaterCloset());
		wcrList.addAll(sanityDetails.getFemaleRoomsWithWaterCloset());
		wcrList.addAll(sanityDetails.getCommonRoomsWithWaterCloset());

		if (!bath.isEmpty()) {
			int count = 0;
			for (Measurement m : bath) {
				if (m.getInvalidReason() != null && m.getInvalidReason().length() > 0) {
					count++;
				}
			}
			if (count > 0) {
				pl.addError("Sanity_" + BLDG_PART_BATHROOM + b.getNumber(), count + " number of " + BLDG_PART_BATHROOM
						+ " polyline not having only 4 points in block" + b.getNumber());

			}
		}

		if (!wcrList.isEmpty()) {
			int count = 0;
			for (Measurement m : wcrList) {
				if (m.getInvalidReason() != null && m.getInvalidReason().length() > 0) {
					count++;
				}
			}

			if (count > 0) {
				pl.addError("Sanity_" + MALE_BATH_WITH_WC + b.getNumber(), count + " number of " + MALE_BATH_WITH_WC
						+ " polyline not having only 4 points in block" + b.getNumber());
			}
		}
	}

	@Override
	public Plan process(Plan pl) {

		OccupancyTypeHelper mostRestrictiveFarHelper = pl.getVirtualBuilding() != null
				? pl.getVirtualBuilding().getMostRestrictiveFarHelper()
				: null;

		if (DxfFileConstants.F_H.equals(mostRestrictiveFarHelper.getSubtype().getCode()))
			return pl;

		verifyDimesions(pl);
		checkCount(pl);
		return pl;
	}

	private Plan verifyDimesions(Plan pl) {
		validate(pl);

		/*
		 * for (Block b : pl.getBlocks()) { If block is small plot and floors above
		 * ground less than or equal to three and occupancy type of entire block is
		 * either Residential or Commercial then sanitation process not require. if
		 * (!Util.checkExemptionConditionForBuildingParts(b) &&
		 * !Util.checkExemptionConditionForSmallPlotAtBlkLevel(pl.getPlot(), b)) {
		 * SanityDetails sanityDetails = b.getSanityDetails(); ScrutinyDetail
		 * scrutinyDetail = getNewScrutinyDetail(BLOCK_U_S + b.getNumber() + "_" +
		 * SANITATION); checkDimension(pl, scrutinyDetail,
		 * sanityDetails.getMaleWaterClosets(), 1d, 1.1d, MALE + BLDG_PART_WATER_CLOSET,
		 * DIMESION_DESC_KEY, RULE_38_1); checkDimension(pl, scrutinyDetail,
		 * sanityDetails.getFemaleWaterClosets(), 1d, 1.1d, FEMALE +
		 * BLDG_PART_WATER_CLOSET, DIMESION_DESC_KEY, RULE_38_1); checkDimension(pl,
		 * scrutinyDetail, sanityDetails.getUrinals(), 0.6d, 0.5d, BLDG_PART_URINAL,
		 * DIMESION_DESC_KEY, RULE_38_1); checkDimension(pl, scrutinyDetail,
		 * sanityDetails.getMaleBathRooms(), 1.1d, 1.5d, MALE + BLDG_PART_BATHROOM,
		 * DIMESION_DESC_KEY, RULE_38_1); checkDimension(pl, scrutinyDetail,
		 * sanityDetails.getFemaleBathRooms(), 1.1d, 1.5d, FEMALE + BLDG_PART_BATHROOM,
		 * DIMESION_DESC_KEY, RULE_38_1); checkDimension(pl, scrutinyDetail,
		 * sanityDetails.getMaleRoomsWithWaterCloset(), 1.1d, 2.2d, MALE_BATH_WITH_WC,
		 * DIMESION_DESC_KEY, RULE_38_1); checkDimension(pl, scrutinyDetail,
		 * sanityDetails.getMaleRoomsWithWaterCloset(), 1.1, 2.2d, FEMALE +
		 * BLDG_PART_BATHROOM + WITH + BLDG_PART_WATER_CLOSET, DIMESION_DESC_KEY,
		 * RULE_38_1); // checkCount(pl); } }
		 */

		return pl;
	}

	private ScrutinyDetail getNewScrutinyDetail(String key) {
		ScrutinyDetail scrutinyDetail = new ScrutinyDetail();
		scrutinyDetail.addColumnHeading(1, RULE_NO);
		scrutinyDetail.addColumnHeading(2, DESCRIPTION);
		scrutinyDetail.addColumnHeading(3, REQUIRED);
		scrutinyDetail.addColumnHeading(4, PROVIDED);
		scrutinyDetail.addColumnHeading(5, STATUS);
		scrutinyDetail.setKey(key);
		return scrutinyDetail;
	}

	private void checkCount(Plan pl) {

		// BigDecimal two=BigDecimal.valueOf(val)
		Boolean allStatus = true;
		Boolean accepted = true;
		for (Block b : pl.getBlocks()) {
			if (!b.getCompletelyExisting()) {

				LOG.info("Starting  Sanitation of ....." + b.getNumber());
				/*
				 * If block is small plot and floors above ground less than or equal to three
				 * and occupancy type of entire block is either Residential or Commercial then
				 * sanitation process not require.
				 */

				ScrutinyDetail scrutinyDetail = getNewScrutinyDetail(BLOCK_U_S + b.getNumber() + "_" + SANITATION);
				SanityHelper helper = new SanityHelper();
				Map<Integer, Integer> requiredSpWcMap = new ConcurrentHashMap<>();
				Map<Integer, Integer> providedSpWcMap = new ConcurrentHashMap<>();
				Map<Integer, Integer> failedAreaSpWcMap = new ConcurrentHashMap<>();
				Map<Integer, Integer> failedDimensionSpWcMap = new ConcurrentHashMap<>();
				Double noOfPerson = CDGAdditionalService.getNumberOfPerson(pl).doubleValue();
				for (Occupancy type : b.getBuilding().getTotalArea()) {
					double carpetArea = 0d;
					if (type.getCarpetArea() != null && type.getCarpetArea().doubleValue() > 0) {
						carpetArea = type.getCarpetArea().doubleValue();
					} else {
						pl.addError("Invalid carpet area",
								"Carpet area is not calculated . Some thing wrong with builtup area");
						return;
					}
					LOG.info(type.getType() + " area" + carpetArea);

					OccupancyHelperDetail o = type.getTypeHelper().getSubtype() != null
							? type.getTypeHelper().getSubtype()
							: type.getTypeHelper().getType();

					switch (o.getCode()) {

					case DxfFileConstants.A:
					case DxfFileConstants.A_P:
//                        if (b.getResidentialBuilding())
//                            accepted = processSpecialWaterClosetForResidential(pl,b, helper, scrutinyDetail,
//                                    requiredSpWcMap, providedSpWcMap, failedAreaSpWcMap, failedDimensionSpWcMap);

						float noOfOwner = pl.getPlanInfoProperties().get(DxfFileConstants.RESIDENTIAL_NO_OWNER) != null
								? Float.parseFloat(
										pl.getPlanInfoProperties().get(DxfFileConstants.RESIDENTIAL_NO_OWNER))
								: 1;
						double requiredWc = 0;
						if (noOfOwner == 1)
							requiredWc = 1;
						else {
							requiredWc = Math.ceil(noOfOwner / 2);
						}
						helper.commonWc = requiredWc;
						helper.commonBath = requiredWc;
						helper.ruleNo.add(CDGAdditionalService.getByLaws(pl, CDGAConstant.WC_AND_POWER_ROOM));
						break;
					case DxfFileConstants.F_SCO:
					case DxfFileConstants.F_B:

						helper.maleWc = (1 / 25) * noOfPerson;
						helper.femaleWc = (1 / 15) * noOfPerson;
						// helper.commonWash = (1 / 25) * noOfPerson;

						double urinal = 0;
						if (noOfPerson >= 7 && noOfPerson <= 20)
							urinal = 1;
						else if (noOfPerson >= 21 && noOfPerson <= 45)
							urinal = 2;
						else if (noOfPerson >= 46 && noOfPerson <= 70)
							urinal = 3;
						else if (noOfPerson >= 71 && noOfPerson <= 100)
							urinal = 4;
						else if (noOfPerson >= 101 && noOfPerson <= 200)
							urinal = noOfPerson * 0.03;
						else
							urinal = noOfPerson * 0.025;
						helper.urinal = urinal;

						helper.drinkingWaterEachFloor = true;
						helper.drinkingWater = noOfPerson * 0.01;

						helper.ruleNo.add(CDGAdditionalService.getByLaws(pl, CDGAConstant.WC_AND_POWER_ROOM));
						break;
					case DxfFileConstants.F_H:
						helper.commonWc = noOfPerson * 0.125;
						helper.commonWash = noOfPerson * 0.1;
						helper.commonBath = noOfPerson * 0.1;
						helper.ruleNo.add(CDGAdditionalService.getByLaws(pl, CDGAConstant.WC_AND_POWER_ROOM));
						break;
					case DxfFileConstants.F_M:
					case DxfFileConstants.ITH_CC:

						if (noOfPerson > 400)
							helper.maleWc = noOfPerson * 0.01 + (noOfPerson > 400 ? ((noOfPerson - 400) * 0.04) : 0);
						else
							helper.maleWc = noOfPerson * 0.01;

						if (noOfPerson > 200)
							helper.femaleWc = noOfPerson * 0.04 + (noOfPerson > 200 ? ((noOfPerson - 200) * 0.02) : 0);
						else
							helper.femaleWc = noOfPerson * 0.04;

						helper.drinkingWater = noOfPerson * 0.01 * 2;
						helper.maleWash = noOfPerson * 0.005;
						helper.femaleWash = noOfPerson * 0.005;

						helper.urinal = noOfPerson * 0.02;

						helper.ruleNo.add(CDGAdditionalService.getByLaws(pl, CDGAConstant.WC_AND_POWER_ROOM));
						break;
					case DxfFileConstants.F_BH:

						if (noOfPerson > 200)
							helper.maleWc = noOfPerson * 0.02 + (noOfPerson > 200 ? ((noOfPerson - 200) * 0.01) : 0);
						else
							helper.maleWc = noOfPerson * 0.02;

						if (noOfPerson > 200)
							helper.femaleWc = noOfPerson * 0.04 + (noOfPerson > 200 ? ((noOfPerson - 200) * 0.02) : 0);
						else
							helper.femaleWc = noOfPerson * 0.04;

						helper.maleWash = noOfPerson * 0.005;
						helper.femaleWash = noOfPerson * 0.005;
						helper.urinal = noOfPerson * 0.02;
						helper.ruleNo.add(CDGAdditionalService.getByLaws(pl, CDGAConstant.WC_AND_POWER_ROOM));
						break;

					case DxfFileConstants.P_D:
					case DxfFileConstants.P_N:
					case DxfFileConstants.P_P:
					case DxfFileConstants.P_F:

						helper.maleWc = noOfPerson * 0.04;
						helper.femaleWc = noOfPerson * 0.133;
						helper.drinkingWater = noOfPerson * 0.01 * 2;
						helper.drinkingWaterEachFloor = true;
						helper.maleWash = noOfPerson * 0.04;
						helper.femaleWash = noOfPerson * 0.04;

						if (noOfPerson >= 7 && noOfPerson <= 20)
							helper.urinal = 1d;
						else if (noOfPerson >= 21 && noOfPerson <= 45)
							helper.urinal = 2d;
						else if (noOfPerson >= 46 && noOfPerson <= 70)
							helper.urinal = 3d;
						else if (noOfPerson >= 71 && noOfPerson <= 100)
							helper.urinal = 4d;
						else if (noOfPerson >= 101 && noOfPerson <= 200)
							helper.urinal = noOfPerson * 0.03;
						else
							urinal = noOfPerson * 0.025;
						helper.ruleNo.add(CDGAdditionalService.getByLaws(pl, CDGAConstant.WC_AND_POWER_ROOM));
						helper.commonBath = 1d;
						processSpecialWaterCloset(b, requiredSpWcMap, providedSpWcMap, failedAreaSpWcMap,
								failedDimensionSpWcMap);
						break;
					case DxfFileConstants.P_H:
						double noOfBed = Double
								.parseDouble(pl.getPlanInfoProperties().get(DxfFileConstants.NO_OF_BEDS));
						helper.commonWc = noOfBed * 0.125;
						helper.maleWc = noOfPerson * 0.01;
						helper.femaleWc = noOfPerson * 0.04;

						helper.drinkingWater = Double
								.parseDouble(pl.getPlanInfoProperties().get(DxfFileConstants.No_Of_WARD)) * 0.01;

						helper.drinkingWater = helper.drinkingWater + (noOfPerson * 0.002);// male
						helper.drinkingWater = helper.drinkingWater + (noOfPerson * 0.002);// female

						helper.commonWash = Math.ceil(2 + (noOfBed > 30 ? ((noOfBed - 30) * 0.033) : 0));
						helper.maleWash = noOfPerson * 0.01;
						helper.femaleWash = noOfPerson * 0.04;

						helper.urinal = noOfBed * 0.033;
						helper.urinal = helper.urinal + (noOfPerson * 0.02);

						processSpecialWaterCloset(b, requiredSpWcMap, providedSpWcMap, failedAreaSpWcMap,
								failedDimensionSpWcMap);
						helper.ruleNo.add(CDGAdditionalService.getByLaws(pl, CDGAConstant.WC_AND_POWER_ROOM));
						break;
					case DxfFileConstants.P_CC:

						if (noOfPerson > 400)
							helper.maleWc = noOfPerson * 0.01 + (noOfPerson > 400 ? ((noOfPerson - 400) * 0.004) : 0);
						else
							helper.maleWc = noOfPerson * 0.001;

						if (noOfPerson > 200)
							helper.femaleWc = noOfPerson * 0.02 + (noOfPerson > 200 ? ((noOfPerson - 200) * 0.01) : 0);
						else
							helper.femaleWc = noOfPerson * 0.02;

						helper.maleWash = helper.maleWc;
						helper.femaleWash = helper.femaleWc;
						helper.urinal = noOfPerson * 0.02;
						helper.maleBath = noOfPerson * 0.1;
						helper.femaleBath = noOfPerson * 0.1;

						processSpecialWaterCloset(b, requiredSpWcMap, providedSpWcMap, failedAreaSpWcMap,
								failedDimensionSpWcMap);
						helper.ruleNo.add(CDGAdditionalService.getByLaws(pl, CDGAConstant.WC_AND_POWER_ROOM));
						break;

					case DxfFileConstants.B_EC:

						helper.maleWc = (noOfPerson * 0.066) / 2;//
						helper.femaleWc = (noOfPerson * 0.166) / 2;//
						helper.drinkingWater = noOfPerson * 0.02;
						helper.commonWash = noOfPerson * 0.066;
						helper.urinal = (noOfPerson * 0.0833) / 2;
						helper.commonBath = noOfPerson * 0.025;

						processSpecialWaterCloset(b, requiredSpWcMap, providedSpWcMap, failedAreaSpWcMap,
								failedDimensionSpWcMap);
						helper.ruleNo.add(CDGAdditionalService.getByLaws(pl, CDGAConstant.WC_AND_POWER_ROOM));
						break;

					case DxfFileConstants.B_HEI:
						if (DxfFileConstants.YES.equals(pl.getPlanInfoProperties().get(DxfFileConstants.IS_BOARDING))) {
							helper.maleWc = (noOfPerson * 0.125) / 2;
							helper.femaleWc = (noOfPerson * 0.166) / 2;

							helper.maleWash = noOfPerson * 0.125;
							helper.femaleWash = noOfPerson * 0.125;

							helper.urinal = noOfPerson * 0.04;
							helper.maleBath = noOfPerson * 0.125;
							helper.femaleBath = noOfPerson * 0.166;

						} else {
							helper.maleWc = (noOfPerson * 0.025) / 2;
							helper.femaleWc = (noOfPerson * 0.04) / 2;

							helper.maleWash = noOfPerson * 0.0166;
							helper.femaleWash = noOfPerson * 0.025;

							helper.urinal = noOfPerson * 0.05;
						}

						processSpecialWaterCloset(b, requiredSpWcMap, providedSpWcMap, failedAreaSpWcMap,
								failedDimensionSpWcMap);
						helper.ruleNo.add(CDGAdditionalService.getByLaws(pl, CDGAConstant.WC_AND_POWER_ROOM));
						break;
					case DxfFileConstants.B_H:

						helper.maleWc = (noOfPerson * 0.125) / 2;
						helper.femaleWc = (noOfPerson * 0.166) / 2;

						helper.maleWash = noOfPerson * 0.125;
						helper.femaleWash = noOfPerson * 0.125;

						helper.urinal = noOfPerson * 0.04;
						helper.maleBath = noOfPerson * 0.125;
						helper.femaleBath = noOfPerson * 0.166;

						processSpecialWaterCloset(b, requiredSpWcMap, providedSpWcMap, failedAreaSpWcMap,
								failedDimensionSpWcMap);
						helper.ruleNo.add(CDGAdditionalService.getByLaws(pl, CDGAConstant.WC_AND_POWER_ROOM));
						break;

					case DxfFileConstants.IT:
					case DxfFileConstants.IT_MCL:
					case DxfFileConstants.IT_MCM:
					case DxfFileConstants.IT_MCS:

						helper.maleWc = (1 / 25) * noOfPerson;
						helper.femaleWc = (1 / 15) * noOfPerson;
						// helper.commonWash = (1 / 25) * noOfPerson;

						double urinal1 = 0;
						if (noOfPerson >= 7 && noOfPerson <= 20)
							urinal1 = 1;
						else if (noOfPerson >= 21 && noOfPerson <= 45)
							urinal1 = 2;
						else if (noOfPerson >= 46 && noOfPerson <= 70)
							urinal1 = 3;
						else if (noOfPerson >= 71 && noOfPerson <= 100)
							urinal1 = 4;
						else if (noOfPerson >= 101 && noOfPerson <= 200)
							urinal1 = noOfPerson * 0.03;
						else
							urinal1 = noOfPerson * 0.025;
						helper.urinal = urinal1;

						helper.drinkingWaterEachFloor = true;
						helper.drinkingWater = noOfPerson * 0.01;

						helper.ruleNo.add(CDGAdditionalService.getByLaws(pl, CDGAConstant.WC_AND_POWER_ROOM));
						break;

					case DxfFileConstants.ITH_H:

						double noOfBed1 = Double
								.parseDouble(pl.getPlanInfoProperties().get(DxfFileConstants.NO_OF_BEDS));
						helper.commonWc = noOfBed1 * 0.125;
						helper.maleWc = noOfPerson * 0.01;
						helper.femaleWc = noOfPerson * 0.04;

						helper.drinkingWater = Double
								.parseDouble(pl.getPlanInfoProperties().get(DxfFileConstants.No_Of_WARD)) * 0.01;

						helper.drinkingWater = helper.drinkingWater + (noOfPerson * 0.002);// male
						helper.drinkingWater = helper.drinkingWater + (noOfPerson * 0.002);// female

						helper.commonWash = Math.ceil(2 + (noOfBed1 > 30 ? ((noOfBed1 - 30) * 0.033) : 0));
						helper.maleWash = noOfPerson * 0.01;
						helper.femaleWash = noOfPerson * 0.04;

						helper.urinal = noOfBed1 * 0.033;
						helper.urinal = helper.urinal + (noOfPerson * 0.02);

						processSpecialWaterCloset(b, requiredSpWcMap, providedSpWcMap, failedAreaSpWcMap,
								failedDimensionSpWcMap);
						helper.ruleNo.add(CDGAdditionalService.getByLaws(pl, CDGAConstant.WC_AND_POWER_ROOM));
						break;

					case DxfFileConstants.ITH_C:

						helper.commonWc = noOfPerson * 0.125;
						helper.commonWash = noOfPerson * 0.1;
						helper.commonBath = noOfPerson * 0.1;
						helper.ruleNo.add(CDGAdditionalService.getByLaws(pl, CDGAConstant.WC_AND_POWER_ROOM));
						break;

					case DxfFileConstants.ITH_R:
					case DxfFileConstants.ITH_GH:

						float noOfOwner1 = pl.getPlanInfoProperties().get(DxfFileConstants.RESIDENTIAL_NO_OWNER) != null
								? Float.parseFloat(
										pl.getPlanInfoProperties().get(DxfFileConstants.RESIDENTIAL_NO_OWNER))
								: 1;

						double requiredWc1 = 0;
						if (noOfOwner1 == 1)
							requiredWc1 = 1;
						else {
							requiredWc1 = Math.ceil(noOfOwner1 / 2);
						}
						helper.commonWc = requiredWc1;
						helper.commonBath = requiredWc1;
						helper.ruleNo.add(CDGAdditionalService.getByLaws(pl, CDGAConstant.WC_AND_POWER_ROOM));
						break;

					}
					if (!accepted) {
						allStatus = false;
					}

				}
				for (Map.Entry<Integer, Integer> req : requiredSpWcMap.entrySet()) {
					helper.requiredSpecialWc += req.getValue();
				}
				for (Map.Entry<Integer, Integer> pro : providedSpWcMap.entrySet()) {
					helper.providedSpecialWc += pro.getValue();
				}
				for (Map.Entry<Integer, Integer> pro : failedAreaSpWcMap.entrySet()) {
					helper.failedAreaSpecialWc += pro.getValue();
				}
				for (Map.Entry<Integer, Integer> pro : failedDimensionSpWcMap.entrySet()) {
					helper.failedDimensionSpecialWc += pro.getValue();
				}

				if (helper.requiredSpecialWc > 0) {
					Set<String> ruleNo = new HashSet<>();
					ruleNo.add(CDGAdditionalService.getByLaws(pl, CDGAConstant.WC_AND_POWER_ROOM));
					if (helper.providedSpecialWc < helper.requiredSpecialWc) {
						addReportDetail(ruleNo, BLDG_PART_SPECIAL_WATER_CLOSET,
								String.valueOf(helper.requiredSpecialWc.intValue()),
								String.valueOf(helper.providedSpecialWc.intValue()), Result.Not_Accepted.getResultVal(),
								scrutinyDetail);
					} else {
						addReportDetail(ruleNo, BLDG_PART_SPECIAL_WATER_CLOSET,
								String.valueOf(helper.requiredSpecialWc.intValue()),
								String.valueOf(helper.providedSpecialWc.intValue()), Result.Accepted.getResultVal(),
								scrutinyDetail);
					}
					if (helper.failedAreaSpecialWc > 0 && helper.failedAreaSpecialWc <= helper.requiredSpecialWc) {
						addReportDetail(ruleNo, BLDG_PART_SPECIAL_WATER_CLOSET + " - Minimum Area", MINIMUM_AREA_SPWC,
								String.valueOf(helper.failedAreaSpecialWc.intValue()) + " not having area 2.625"
										+ DxfFileConstants.METER_SQM,
								Result.Not_Accepted.getResultVal(), scrutinyDetail);
					} else {
						addReportDetail(ruleNo, BLDG_PART_SPECIAL_WATER_CLOSET + " - Minimum Area", MINIMUM_AREA_SPWC,
								String.valueOf(
										helper.providedSpecialWc.intValue() - helper.failedAreaSpecialWc.intValue())
										+ " having area 2.625" + DxfFileConstants.METER_SQM,
								Result.Accepted.getResultVal(), scrutinyDetail);
					}

					if (helper.failedDimensionSpecialWc > 0
							&& helper.failedDimensionSpecialWc <= helper.requiredSpecialWc) {
						addReportDetail(ruleNo, BLDG_PART_SPECIAL_WATER_CLOSET + " - Minimum Dimension",
								MINIMUM_DIMENSION_SPWC, String.valueOf(helper.failedDimensionSpecialWc.intValue())
										+ " not having dimension 1.5" + DxfFileConstants.METER,
								Result.Not_Accepted.getResultVal(), scrutinyDetail);
					} else {
						addReportDetail(ruleNo, BLDG_PART_SPECIAL_WATER_CLOSET + " - Minimum Dimension",
								MINIMUM_DIMENSION_SPWC,
								String.valueOf(helper.providedSpecialWc.intValue()
										- helper.failedDimensionSpecialWc.intValue()) + " having dimension 1.5"
										+ DxfFileConstants.METER,
								Result.Accepted.getResultVal(), scrutinyDetail);
					}

				}
				accepted = processSanity(pl, b, helper, scrutinyDetail);

				pl.getReportOutput().getScrutinyDetails().add(scrutinyDetail);
				LOG.info("Keys of the Sanitation Message ....." + scrutinyDetail.getKey() + "   "
						+ scrutinyDetail.getDetail().size());
			}
		}
	}

	/*
	 * private Boolean processSpecialWaterCloset(Block block, SanityHelper helper,
	 * ScrutinyDetail detail, Map<Integer, Integer> spWcMap) { boolean notFound =
	 * false; StringBuilder expectedResult = new StringBuilder(); StringBuilder
	 * actualResult = new StringBuilder(); expectedResult.append(
	 * " Minimum one at Ground Floor + Minimum 1 at every floors in multiples of 3, (GF, 3rd, 6th etc)"
	 * ); StringBuilder notFoundFloors = new StringBuilder(); StringBuilder
	 * foundFloors = new StringBuilder(); int required = 0; int provided = 0; for
	 * (Floor f : block.getBuilding().getFloors()) { if (f.getNumber().intValue() <
	 * 0) continue; if (f.getNumber() % 3 == 0) {
	 * if(spWcMap.containsKey(f.getNumber())) continue; else
	 * spWcMap.put(f.getNumber(), 1); required++; if
	 * (f.getSpecialWaterClosets().isEmpty()) { notFound = true; if
	 * (notFoundFloors.length() != 0) notFoundFloors.append(", ");
	 * notFoundFloors.append(" Floor " + f.getNumber()); } else { provided++;
	 * foundFloors.append(" Floor " + f.getNumber()); } } } if (notFound) {
	 * actualResult.append("Not found at following Mandatory levels " +
	 * notFoundFloors); addReportDetail(RULE_40_A_4, BLDG_PART_SPECIAL_WATER_CLOSET
	 * +
	 * " - Minimum one at Ground Floor + Minimum 1 at every floors in multiples of 3, (GF, 3rd, 6th etc)"
	 * , String.valueOf(required), String.valueOf(provided),
	 * Result.Not_Accepted.getResultVal(), detail); } else {
	 * actualResult.append(" found at following Mandatory levels " + foundFloors);
	 * addReportDetail(RULE_40_A_4, BLDG_PART_SPECIAL_WATER_CLOSET +
	 * " - Minimum one at Ground Floor + Minimum 1 at every floors in multiples of 3, (GF, 3rd, 6th etc)"
	 * , String.valueOf(required), String.valueOf(provided),
	 * Result.Accepted.getResultVal(), detail); } return !notFound; }
	 */

	private void processSpecialWaterCloset(Block block, Map<Integer, Integer> requiredSpWcMap,
			Map<Integer, Integer> providedSpWcMap, Map<Integer, Integer> failedAreaSpWcMap,
			Map<Integer, Integer> failedDimensionSpWcMap) {

		// check required spWC

		for (Floor f : block.getBuilding().getFloors()) {
			if (f.getBathRoomWaterClosets() != null && f.getBathRoomWaterClosets().getHeights() != null
					&& !f.getBathRoomWaterClosets().getHeights().isEmpty()
					&& f.getBathRoomWaterClosets().getRooms() != null
					&& !f.getBathRoomWaterClosets().getRooms().isEmpty())
				requiredSpWcMap.put(f.getNumber(), 1);
		}

		for (Floor f : block.getBuilding().getFloors()) {

			if (f.getSpecialWaterClosets().isEmpty()) {
				// not defined
			} else {
				if (providedSpWcMap.containsKey(f.getNumber()))
					continue;
				else
					providedSpWcMap.put(f.getNumber(), 1);
			}

			validateDimensionOfSPWC(f.getSpecialWaterClosets(), f.getNumber(), failedAreaSpWcMap,
					failedDimensionSpWcMap, providedSpWcMap);

		}
	}

	private Boolean processSpecialWaterClosetForResidential(Plan plan, Block block, SanityHelper helper,
			ScrutinyDetail detail, Map<Integer, Integer> requiredSpWcMap, Map<Integer, Integer> providedSpWcMap,
			Map<Integer, Integer> failedAreaSpWcMap, Map<Integer, Integer> failedDimensionSpWcMap) {
		boolean notFound = false;
		StringBuilder expectedResult = new StringBuilder();
		StringBuilder actualResult = new StringBuilder();
		expectedResult.append(" Minimum one at Ground Floor");
		int required = 0;
		int provided = 0;
		for (Floor f : block.getBuilding().getFloors()) {
			if (f.getNumber().intValue() < 0)
				continue;
			if (f.getNumber() == 0) {
				required++;
				provided++;
				if (f.getSpecialWaterClosets().isEmpty()) {
					notFound = true;
				}

				validateDimensionOfSPWC(f.getSpecialWaterClosets(), f.getNumber(), failedAreaSpWcMap,
						failedDimensionSpWcMap, providedSpWcMap);

			}
		}
		Set<String> ruleNo = new HashSet<>();
		ruleNo.add(CDGAdditionalService.getByLaws(plan, CDGAConstant.WC_AND_POWER_ROOM));
		if (notFound) {
			actualResult.append("Not Found");
			addReportDetail(ruleNo, BLDG_PART_SPECIAL_WATER_CLOSET + " - Minimum one at Ground Floor",
					String.valueOf(required), String.valueOf(provided), Result.Not_Accepted.getResultVal(), detail);
		} else {
			actualResult.append("Found");
			addReportDetail(ruleNo, BLDG_PART_SPECIAL_WATER_CLOSET + " - Minimum one at Ground Floor",
					String.valueOf(required), String.valueOf(provided), Result.Accepted.getResultVal(), detail);
		}

		return !notFound;
	}

	/*
	 * private Boolean processWashBasinsFloorWise(PlanDetail planDetail, Block
	 * block, SanityHelper helper, ScrutinyDetail detail, Occupancy occupancy) {
	 * helper.ruleDescription = "" + BLDG_PART_WASHBASIN; Set<String> ruleNo = new
	 * HashSet<>(); ruleNo.add(RULE_54_6); boolean found = false; StringBuilder
	 * expectedResult = new StringBuilder(); StringBuilder actualResult = new
	 * StringBuilder(); expectedResult.append("Preferably one at each floor ");
	 * StringBuilder foundFloors = new StringBuilder(); for (Floor f :
	 * block.getBuilding().getFloors()) { if (f.getNumber().intValue() < 0)
	 * continue; if (!f.getWashBasins().isEmpty()) { found = true; if
	 * (foundFloors.length() != 0) foundFloors.append(", ");
	 * foundFloors.append(" Floor " + f.getNumber()); } } if (found) {
	 * actualResult.append("Found at " + foundFloors); addReportDetail(ruleNo,
	 * helper.ruleDescription, expectedResult.toString(), actualResult.toString(),
	 * Result.Accepted.getResultVal(), detail); } return found; }
	 */

	private Boolean processSanity(Plan pl, Block b, SanityHelper helper, ScrutinyDetail detail) {

		// int specialWC = sanityDetails.getTotalSpecialWC().size();

		Boolean accepted = true;
		String description = "";
		String expected = "";
		String actual = "";
		SanityDetails sanityDetails = b.getSanityDetails();

		if (helper.commonWc > 0) {
			int commonWcActual = sanityDetails.getCommonWaterClosets().size()
					+ sanityDetails.getCommonRoomsWithWaterCloset().size();

			Double totalWCActual = Math.ceil(commonWcActual);
			Double totalWCExpected = Math.ceil(helper.commonWc);
			if (totalWCExpected >= 0) {
				List<Measurement> wcList = new ArrayList<>();
				wcList.addAll(sanityDetails.getMaleWaterClosets());
				wcList.addAll(sanityDetails.getFemaleWaterClosets());
				wcList.addAll(sanityDetails.getCommonWaterClosets());
//                checkDimension(totalWCExpected.intValue(), detail, wcList, 1d, 1.1d, BLDG_PART_WATER_CLOSET,
//                        DIMESION_DESC_KEY, CDGAdditionalService.getByLaws(pl, CDGAConstant.WC_AND_POWER_ROOM));

				expected = "" + totalWCExpected.intValue();
				actual = "" + totalWCActual.intValue();
				description = BLDG_PART_WATER_CLOSET + " Common - Count";
				if (totalWCExpected.intValue() > totalWCActual.intValue()) {
					addReportDetail(helper.ruleNo, description, expected, actual, Result.Not_Accepted.getResultVal(),
							detail);
				} else {
					addReportDetail(helper.ruleNo, description, expected, actual, Result.Accepted.getResultVal(),
							detail);

				}
			}
		}

		if (helper.maleWc > 0) {

			int maleWcActual = sanityDetails.getMaleWaterClosets().size()
					+ sanityDetails.getMaleRoomsWithWaterCloset().size();

			Double totalWCActual = Math.ceil(maleWcActual);
			Double totalWCExpected = Math.ceil(helper.maleWc + helper.femaleWc + helper.commonWc);
			if (totalWCExpected >= 0) {
				List<Measurement> wcList = new ArrayList<>();
				wcList.addAll(sanityDetails.getMaleWaterClosets());
				wcList.addAll(sanityDetails.getFemaleWaterClosets());
				wcList.addAll(sanityDetails.getCommonWaterClosets());
//                checkDimension(totalWCExpected.intValue(), detail, wcList, 1d, 1.1d, BLDG_PART_WATER_CLOSET,
//                        DIMESION_DESC_KEY, CDGAdditionalService.getByLaws(pl, CDGAConstant.WC_AND_POWER_ROOM));

				expected = "" + totalWCExpected.intValue();
				actual = "" + totalWCActual.intValue();
				description = BLDG_PART_WATER_CLOSET + " Male - Count";
				if (totalWCExpected.intValue() > totalWCActual.intValue()) {
					addReportDetail(helper.ruleNo, description, expected, actual, Result.Not_Accepted.getResultVal(),
							detail);
				} else {
					addReportDetail(helper.ruleNo, description, expected, actual, Result.Accepted.getResultVal(),
							detail);

				}
			}
		}

		if (helper.femaleWc > 0) {

			int femaleWcActual = sanityDetails.getFemaleWaterClosets().size()
					+ sanityDetails.getFemaleRoomsWithWaterCloset().size();

			Double totalWCActual = Math.ceil(femaleWcActual);
			Double totalWCExpected = Math.ceil(helper.maleWc + helper.femaleWc + helper.commonWc);
			if (totalWCExpected >= 0) {
				List<Measurement> wcList = new ArrayList<>();
				wcList.addAll(sanityDetails.getMaleWaterClosets());
				wcList.addAll(sanityDetails.getFemaleWaterClosets());
				wcList.addAll(sanityDetails.getCommonWaterClosets());
				checkDimension(totalWCExpected.intValue(), detail, wcList, 1d, 1.1d, BLDG_PART_WATER_CLOSET,
						DIMESION_DESC_KEY, CDGAdditionalService.getByLaws(pl, CDGAConstant.WC_AND_POWER_ROOM));

				expected = "" + totalWCExpected.intValue();
				actual = "" + totalWCActual.intValue();
				description = BLDG_PART_WATER_CLOSET + " Female - Count";
				if (totalWCExpected.intValue() > totalWCActual.intValue()) {
					addReportDetail(helper.ruleNo, description, expected, actual, Result.Not_Accepted.getResultVal(),
							detail);
				} else {
					addReportDetail(helper.ruleNo, description, expected, actual, Result.Accepted.getResultVal(),
							detail);

				}
			}
		}

		if (helper.urinal > 0) {
			helper.urinal = Math.ceil(helper.urinal);
			description = BLDG_PART_URINAL + " - Count";
			Integer urinalActual = sanityDetails.getUrinals().size();
			expected = "" + helper.urinal.intValue();
			actual = "" + urinalActual.intValue();
			if (helper.urinal.intValue() >= 0) {

				if (helper.urinal.intValue() > urinalActual.intValue()) {
					addReportDetail(helper.ruleNo, description, expected, actual, Result.Not_Accepted.getResultVal(),
							detail);
				} else {
					addReportDetail(helper.ruleNo, description, expected, actual, Result.Accepted.getResultVal(),
							detail);
				}
			}
		}

		if (helper.drinkingWater > 0) {
			helper.drinkingWater = Math.ceil(helper.drinkingWater);
			description = BLDG_DRINKING_WATER + " - Count";
			Integer urinalActual = sanityDetails.getDrinkingWater().size();
			expected = "" + helper.drinkingWater.intValue();
			actual = "" + urinalActual.intValue();
			if (helper.drinkingWater.intValue() >= 0) {

				if (helper.drinkingWater.intValue() > urinalActual.intValue()) {
					addReportDetail(helper.ruleNo, description, expected, actual, Result.Not_Accepted.getResultVal(),
							detail);
				} else {
					addReportDetail(helper.ruleNo, description, expected, actual, Result.Accepted.getResultVal(),
							detail);
				}

				if (helper.drinkingWaterEachFloor) {
					if (!DxfFileConstants.YES
							.equals(pl.getPlanInfoProperties().get(DxfFileConstants.IS_DRINKING_WATER_ON_EACH_FLOOR)))
						pl.addError("IS_DRINKING_WATER_ON_EACH_FLOOR",
								"IS_DRINKING_WATER_ON_EACH_FLOOR No defined in plan info");
				}
			}

		}

		if (helper.maleWash > 0 || helper.femaleWash > 0) {

			int actualWash = 0;
			for (Floor f : b.getBuilding().getFloors()) {
				actualWash += f.getWashBasins().size();
			}
			description = BLDG_PART_WASHBASIN + " - Count";
			Double totalWashExpected = Math.ceil(helper.maleWash + helper.femaleWash + helper.commonWash);
			expected = "" + totalWashExpected.intValue();
			actual = "" + actualWash;
			if (totalWashExpected.intValue() >= 0) {
				if (totalWashExpected.intValue() > actualWash) {
					addReportDetail(helper.ruleNo, description, expected, actual, Result.Not_Accepted.getResultVal(),
							detail);
				} else {
					addReportDetail(helper.ruleNo, description, expected, actual, Result.Accepted.getResultVal(),
							detail);
				}
			}
		}

		List<Measurement> commonBaths = new ArrayList<Measurement>();
		List<Measurement> maleBaths = new ArrayList<Measurement>();

		// new for separated male and common - start
		for (Measurement Bath : sanityDetails.getMaleBathRooms()) {
			if (Bath.getColorCode() == 3) {//
				commonBaths.add(Bath);
			} else if (Bath.getColorCode() == 1) {
				maleBaths.add(Bath);
			}
		}

		if (!commonBaths.isEmpty())
			sanityDetails.setCommonBathRooms(commonBaths);
		if (!maleBaths.isEmpty())
			sanityDetails.setMaleBathRooms(maleBaths);

		// new for separated male and common -end

		if (helper.commonBath > 0) {
			description = BLDG_PART_BATHROOM + " Common - Count";

			int commomBathActual = sanityDetails.getCommonBathRooms().size();

			int totalActualBath = commomBathActual;
			Double totalBathExpected = Math.ceil(helper.commonBath);

			expected = "" + totalBathExpected.intValue();
			actual = "" + totalActualBath;
			List<Measurement> wcList = new ArrayList<>();
			wcList.addAll(sanityDetails.getMaleBathRooms());
			wcList.addAll(sanityDetails.getFemaleBathRooms());
			wcList.addAll(sanityDetails.getCommonBathRooms());

			List<Measurement> wcrList = new ArrayList<>();
			wcrList.addAll(sanityDetails.getMaleRoomsWithWaterCloset());
			wcrList.addAll(sanityDetails.getFemaleRoomsWithWaterCloset());
			wcrList.addAll(sanityDetails.getCommonRoomsWithWaterCloset());
			if (totalBathExpected.intValue() >= 0) {
//                checkDimension(totalBathExpected.intValue(), detail, wcList, 1.1d, 1.5d, BLDG_PART_BATHROOM,
//                        DIMESION_DESC_KEY, CDGAdditionalService.getByLaws(pl, CDGAConstant.WC_AND_POWER_ROOM));
//
//                checkDimension(totalBathExpected.intValue(), detail, wcrList, 1.1d, 2.2d, MALE_BATH_WITH_WC,
//                        DIMESION_DESC_KEY, CDGAdditionalService.getByLaws(pl, CDGAConstant.WC_AND_POWER_ROOM));

				if (totalBathExpected.intValue() > totalActualBath) {
					addReportDetail(helper.ruleNo, description, expected, actual, Result.Not_Accepted.getResultVal(),
							detail);
				} else {
					addReportDetail(helper.ruleNo, description, expected, actual, Result.Accepted.getResultVal(),
							detail);

				}
			}
		}
		if (helper.maleBath > 0) {
			description = BLDG_PART_BATHROOM + " Male - Count";
			int maleBathActual = sanityDetails.getMaleBathRooms().size();

			int totalActualBath = maleBathActual;
			Double totalBathExpected = Math.ceil(helper.maleBath);

			expected = "" + totalBathExpected.intValue();
			actual = "" + totalActualBath;
			List<Measurement> wcList = new ArrayList<>();
			wcList.addAll(sanityDetails.getMaleBathRooms());
			wcList.addAll(sanityDetails.getFemaleBathRooms());
			wcList.addAll(sanityDetails.getCommonBathRooms());

			List<Measurement> wcrList = new ArrayList<>();
			wcrList.addAll(sanityDetails.getMaleRoomsWithWaterCloset());
			wcrList.addAll(sanityDetails.getFemaleRoomsWithWaterCloset());
			wcrList.addAll(sanityDetails.getCommonRoomsWithWaterCloset());
			if (totalBathExpected.intValue() >= 0) {
//                checkDimension(totalBathExpected.intValue(), detail, wcList, 1.1d, 1.5d, BLDG_PART_BATHROOM,
//                        DIMESION_DESC_KEY, CDGAdditionalService.getByLaws(pl, CDGAConstant.WC_AND_POWER_ROOM));
//
//                checkDimension(totalBathExpected.intValue(), detail, wcrList, 1.1d, 2.2d, MALE_BATH_WITH_WC,
//                        DIMESION_DESC_KEY, CDGAdditionalService.getByLaws(pl, CDGAConstant.WC_AND_POWER_ROOM));

				if (totalBathExpected.intValue() > totalActualBath) {
					addReportDetail(helper.ruleNo, description, expected, actual, Result.Not_Accepted.getResultVal(),
							detail);
				} else {
					addReportDetail(helper.ruleNo, description, expected, actual, Result.Accepted.getResultVal(),
							detail);

				}
			}
		}
		if (helper.femaleBath > 0) {
			description = BLDG_PART_BATHROOM + " female - Count";
			int femaleBathActual = sanityDetails.getFemaleBathRooms().size();

			int totalActualBath = femaleBathActual;
			Double totalBathExpected = Math.ceil(helper.femaleBath);

			expected = "" + totalBathExpected.intValue();
			actual = "" + totalActualBath;
			List<Measurement> wcList = new ArrayList<>();
			wcList.addAll(sanityDetails.getMaleBathRooms());
			wcList.addAll(sanityDetails.getFemaleBathRooms());
			wcList.addAll(sanityDetails.getCommonBathRooms());

			List<Measurement> wcrList = new ArrayList<>();
			wcrList.addAll(sanityDetails.getMaleRoomsWithWaterCloset());
			wcrList.addAll(sanityDetails.getFemaleRoomsWithWaterCloset());
			wcrList.addAll(sanityDetails.getCommonRoomsWithWaterCloset());
			if (totalBathExpected.intValue() >= 0) {
				checkDimension(totalBathExpected.intValue(), detail, wcList, 1.1d, 1.5d, BLDG_PART_BATHROOM,
						DIMESION_DESC_KEY, CDGAdditionalService.getByLaws(pl, CDGAConstant.WC_AND_POWER_ROOM));

				checkDimension(totalBathExpected.intValue(), detail, wcrList, 1.1d, 2.2d, MALE_BATH_WITH_WC,
						DIMESION_DESC_KEY, CDGAdditionalService.getByLaws(pl, CDGAConstant.WC_AND_POWER_ROOM));

				if (totalBathExpected.intValue() > totalActualBath) {
					addReportDetail(helper.ruleNo, description, expected, actual, Result.Not_Accepted.getResultVal(),
							detail);
				} else {
					addReportDetail(helper.ruleNo, description, expected, actual, Result.Accepted.getResultVal(),
							detail);

				}
			}
		}

		/*
		 * if (pl.getPlanInformation().getNoOfBeds() != null &&
		 * OCCUPANCY_C1.equals(occupancy.getType())) addReportDetail(RULE_55_12,
		 * NOOFBEDS, "-", pl.getPlanInformation().getNoOfBeds().toString(),
		 * Result.Accepted.getResultVal(), detail);
		 */
		return accepted;
	}

	private boolean checkDimension(Integer required, ScrutinyDetail scrutinyDetail, List<Measurement> list,
			double minSide, double minArea, String type, String desc, String ruleNum) {
		if (!list.isEmpty()) {
			int wcNotMeetingSide = checkDimensionSide(list, minSide);
			int wcNotMeetingArea = checkDimensionArea(list, minArea);

			int totalSize = list.size();
			desc = type + "- Minimum Dimension";

			String expectedResult = minSide + " M";
			String actualResult = "";
			Set<String> ruleNo = new HashSet<>();
			ruleNo.add(ruleNum);
			if (totalSize - wcNotMeetingSide < required && wcNotMeetingSide > 0) {
				actualResult = wcNotMeetingSide + " not having " + expectedResult;
				addReportDetail(ruleNo, desc, expectedResult, actualResult, Result.Not_Accepted.getResultVal(),
						scrutinyDetail);

			} else {
				actualResult = totalSize + " having " + expectedResult;
				addReportDetail(ruleNo, desc, expectedResult, actualResult, Result.Accepted.getResultVal(),
						scrutinyDetail);
			}

			desc = type + "- Minimum Area";
			expectedResult = minArea + " M2";
			if (totalSize - wcNotMeetingArea < required && wcNotMeetingArea > 0) {
				actualResult = wcNotMeetingArea + " not having " + expectedResult;
				addReportDetail(ruleNo, desc, expectedResult, actualResult, Result.Not_Accepted.getResultVal(),
						scrutinyDetail);

			} else {
				actualResult = totalSize + "  having " + expectedResult;
				addReportDetail(ruleNo, desc, expectedResult, actualResult, Result.Accepted.getResultVal(),
						scrutinyDetail);
			}

		}
		return true;
	}

	private void addReportDetail(Set<String> ruleNo, String ruleDesc, String expected, String actual, String status,
			ScrutinyDetail detail) {
		Map<String, String> details = new HashMap<>();
		details.put(RULE_NO, ruleNo.stream().map(String::new).collect(Collectors.joining(",")));
		details.put(DESCRIPTION, ruleDesc);
		details.put(REQUIRED, expected);
		details.put(PROVIDED, actual);
		details.put(STATUS, status);
		detail.getDetail().add(details);

	}

	private int checkDimensionSide(List<Measurement> measurements, Double minValue) {
		int failedCount = 0;
		for (Measurement m : measurements) {
			if (minValue == 0) {

			}
			double minSide = m.getMinimumSide()
					.setScale(DcrConstants.ONE_DECIMALDIGITS_MEASUREMENTS, DcrConstants.ROUNDMODE_MEASUREMENTS)
					.doubleValue();
			if (minSide < minValue) {
				m.setIsValid(false);
				m.appendInvalidReason(String.format(MINIMUM_SIDE_DIMENSION_VIOLATED, minValue));
				failedCount++;
			}
		}
		return failedCount;
	}

	private int checkDimensionArea(List<Measurement> measurements, Double minValue) {
		int failedCount = 0;
		for (Measurement m : measurements) {

			double area = m.getArea()
					.setScale(DcrConstants.THREE_DECIMALDIGITS_MEASUREMENTS, DcrConstants.ROUNDMODE_MEASUREMENTS)
					.doubleValue();
			if (area < minValue) {
				m.setIsValid(false);
				m.appendInvalidReason(String.format(MINIMUM_AREA_DIMENSION_VIOLATED, minValue));
				failedCount++;
				LOG.debug("Area not matching is " + m.getArea());
			}
		}
		return failedCount;
	}

	private void validateDimensionOfSPWC(List<Measurement> spwcs, int flrNo, Map<Integer, Integer> failedAreaSpWcMap,
			Map<Integer, Integer> failedDimensionSpWcMap, Map<Integer, Integer> providedSpWcMap) {

		Integer failedAreaCount = 0;
		Integer failedDimensionCount = 0;
		Integer providedSpecialWc = 0;

		for (Map.Entry<Integer, Integer> pro : providedSpWcMap.entrySet()) {
			providedSpecialWc += pro.getValue();
		}

		for (Measurement spwc : spwcs) {
			BigDecimal area = spwc.getArea().setScale(DcrConstants.THREE_DECIMALDIGITS_MEASUREMENTS,
					DcrConstants.ROUNDMODE_MEASUREMENTS);
			BigDecimal width = spwc.getWidth().setScale(DcrConstants.ONE_DECIMALDIGITS_MEASUREMENTS,
					DcrConstants.ROUNDMODE_MEASUREMENTS);
			if (area.compareTo(MINAREAOFSPWC.setScale(DcrConstants.THREE_DECIMALDIGITS_MEASUREMENTS,
					DcrConstants.ROUNDMODE_MEASUREMENTS)) < 0) {
				failedAreaCount++;
			}
			if (width.compareTo(MINDIMENSIONOFSPWC.setScale(DcrConstants.ONE_DECIMALDIGITS_MEASUREMENTS,
					DcrConstants.ROUNDMODE_MEASUREMENTS)) < 0) {
				failedDimensionCount++;
			}

			if (providedSpecialWc == failedAreaCount) {
				failedAreaSpWcMap.put(flrNo, failedAreaCount);
			}

			if (providedSpecialWc == failedDimensionCount) {
				failedDimensionSpWcMap.put(flrNo, failedAreaCount);
			}

		}

	}

	@Override
	public Map<String, Date> getAmendments() {
		return new LinkedHashMap<>();
	}
}
