package org.egov.common.entity.bpa;

import java.math.BigDecimal;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.validation.constraints.PositiveOrZero;

@Entity
@Table(name = "EGBPA_OCCUPANCY_MAPPING")
@SequenceGenerator(name = OccupancyMapping.SEQ_OCCUPANCY, sequenceName = OccupancyMapping.SEQ_OCCUPANCY, allocationSize = 1)
public class OccupancyMapping {

	public static final String SEQ_OCCUPANCY = "SEQ_EGBPA_OCCUPANCY_MAPPING";
	private static final long serialVersionUID = -1928622582218032380L;

	@Id
	@GeneratedValue(generator = SEQ_OCCUPANCY, strategy = GenerationType.SEQUENCE)
	private Long id;

	@PositiveOrZero
	private BigDecimal fromArea;

	@PositiveOrZero
	private BigDecimal toArea;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "occpancy")
	private Occupancy occpancy;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "subOccupancy")
	private SubOccupancy subOccupancy;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "alternateOccupancy")
	private Occupancy alternateOccupancy;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "alternateSuboccupancy")
	private SubOccupancy alternateSuboccupancy;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public BigDecimal getFromArea() {
		return fromArea;
	}

	public void setFromArea(BigDecimal fromArea) {
		this.fromArea = fromArea;
	}

	public BigDecimal getToArea() {
		return toArea;
	}

	public void setToArea(BigDecimal toArea) {
		this.toArea = toArea;
	}

	public Occupancy getOccpancy() {
		return occpancy;
	}

	public void setOccpancy(Occupancy occpancy) {
		this.occpancy = occpancy;
	}

	public SubOccupancy getSubOccupancy() {
		return subOccupancy;
	}

	public void setSubOccupancy(SubOccupancy suboccupancy) {
		this.subOccupancy = suboccupancy;
	}

	public Occupancy getAlternateOccupancy() {
		return alternateOccupancy;
	}

	public void setAlternateOccupancy(Occupancy alternateOccupancy) {
		this.alternateOccupancy = alternateOccupancy;
	}

	public SubOccupancy getAlternateSuboccupancy() {
		return alternateSuboccupancy;
	}

	public void setAlternateSuboccupancy(SubOccupancy alternateSuboccupancy) {
		this.alternateSuboccupancy = alternateSuboccupancy;
	}

}
