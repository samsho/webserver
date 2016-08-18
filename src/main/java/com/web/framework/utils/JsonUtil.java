package com.web.framework.utils;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.hibernate5.Hibernate5Module;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.google.common.collect.ImmutableMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

/**
 * ClassName: JsonUtil
 * Description:
 * Date: 2015/6/29 9:29
 *
 * @author sam-sho
 * @version V1.0
 */
public class JsonUtil {
    private static final Logger logger = LoggerFactory.getLogger(JsonUtil.class);
    private static final ObjectMapper jsonMapper = initedObjectMapper();

    private JsonUtil() {

    }

    public static String toJson(Object object) throws IOException {
        return jsonMapper.writeValueAsString(object);
    }

    public static byte[] toBytes(Object object) throws IOException {
        return jsonMapper.writeValueAsBytes(object);
    }

    public static <T> T load(String value, Class<T> clazz) throws IOException {
        return jsonMapper.readValue(value, clazz);
    }

    public static <T> T load(byte[] bytes, Class<T> clazz) throws IOException {
        return jsonMapper.readValue(bytes, clazz);
    }

    public static <K, V> HashMap<K, V> load(String value) throws IOException {
        return jsonMapper.readValue(value, new TypeReference<HashMap<K, V>>() {
        });
    }

    public static <T> ArrayList<T> load2List(String value) throws IOException {
        return jsonMapper.readValue(value, new TypeReference<ArrayList<T>>() {
        });
    }


    public static String getErrorJson(String errorMessage) {
        try {
            return toJson(ImmutableMap.of("error", errorMessage));
        } catch (IOException e) {
            logger.warn("转换json时出错", e);
            return String.format("{\"error\":\"%s\"}", errorMessage);
        }
    }

    public static String getStatusAndErrorInfoJson(int status, String errorInfo) {
        try {
            return toJson(ImmutableMap.of("status", status, "errorInfo", errorInfo));
        } catch (IOException e) {
            logger.warn("转换json时出错", e);
            return String.format("{\"status\":\"%s\",\"errorInfo\":\"%s\"}", status, errorInfo);
        }
    }

    public static <K, V> HashMap<K, V> convertValue(Object object) {
        return jsonMapper.convertValue(object, new TypeReference<HashMap<K, V>>() {// TODO 日期类型返回的是字符串
        });
    }

    /**
     * @return 添加了DateFormat的ObjectMapper
     */
    private static ObjectMapper initedObjectMapper() {
        ObjectMapper mapper = new ObjectMapper();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        mapper.registerModule(new JavaTimeModule());
        mapper.setDateFormat(sdf);
        try {
            Class.forName("org.hibernate.SessionFactory");
            mapper.registerModule(new Hibernate5Module());
        } catch (ClassNotFoundException ignore) {

        }

        return mapper;
    }
}
