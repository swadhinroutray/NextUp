//TODO: Add S3 bucket upload functions here

// const { response } = require("express");

async function uploadS3(file, filename) {
    try {
      const requestData = {
        Bucket: process.env.BUCKET_NAME,
        Key: filename,
        Body: file.buffer,
      };
      await s3.upload(requestData, (data) => {
        if (data) {
          console.log(data);
          response = {
            success: true,
            data: data,
          };
          return response;
        } else {
          response = {
            success: false,
          };
          return response;
        }
      });
    } catch (err) {
      console.log(err);
      return err;
    }
  }
  
  async function deleteS3(filename) {
    try {
      var params = {
        Bucket: process.env.BUCKET_NAME,
        Delete: {
          Objects: [{ Key: filename }],
        },
      };
      await s3.deleteObjects(params).promise();
    } catch (err) {
      console.log(err);
      return err;
    }
  }
  module.exports = { uploadS3, deleteS3 };
  