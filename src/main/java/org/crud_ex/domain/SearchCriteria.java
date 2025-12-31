package org.crud_ex.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SearchCriteria {

	private String searchType; // title, writer, content, titleOrContent
	private String keyword; // 검색어

	// 검색 타입 확인 메서드
	public boolean hasSearchType() {
		return searchType != null && !searchType.trim().isEmpty();
	}

	public boolean hasKeyword() {
		return keyword != null && !keyword.trim().isEmpty();
	}

	public boolean isSearchable() {
		return hasSearchType() && hasKeyword();
	}
}
